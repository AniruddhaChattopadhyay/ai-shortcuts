#!/usr/bin/env osascript -l JavaScript

function run(argv) {
  var app = Application.currentApplication();
  app.includeStandardAdditions = true;

  // 1. Get the Input Text (passed as an argument)
  var inputText = argv[0];
  if (!inputText) return;

  // 2. Read the API Key from config
  var home = app.systemAttribute('HOME');
  var configPath = home + "/.mac-ai-companion/config.json";
  
  try {
      var configStr = app.read(Path(configPath));
      var config = JSON.parse(configStr);
      var apiKey = config.api_key;
  } catch (e) {
      return "Error: Could not read API Key. Please reinstall.";
  }

  // 3. Prepare the JSON Payload
  // We write to a temp file to avoid escaping issues in the shell command
  var payload = {
      "model": "gpt-4o-mini",
      "messages": [
          {"role": "system", "content": "Rewrite the user's text to be clear, professional, and concise. Only output the rewritten text."},
          {"role": "user", "content": inputText}
      ]
  };
  
  var tempFile = "/tmp/ai_request_" + (Math.floor(Math.random() * 10000)) + ".json";
  var strPayload = JSON.stringify(payload);
  
  // Write payload to temp file
  var file = app.openForAccess(Path(tempFile), {writePermission: true});
  app.setEof(file, {to: 0}); // Clear file
  app.write(strPayload, {to: file, startingAt: 0});
  app.closeAccess(file);

  // 4. Send Request using cURL (built-in tool)
  // We use @filename to let curl handle the JSON upload safely
  var curlCommand = 'curl -s -X POST https://api.openai.com/v1/chat/completions ' +
                    '-H "Content-Type: application/json" ' +
                    '-H "Authorization: Bearer ' + apiKey + '" ' +
                    '-d @' + tempFile;

  try {
      var response = app.doShellScript(curlCommand);
      var json = JSON.parse(response);
      
      // Cleanup temp file
      app.doShellScript('rm ' + tempFile);

      // 5. Output Result
      if (json.choices && json.choices.length > 0) {
          return json.choices[0].message.content;
      } else {
          return inputText; // Return original if API fails
      }
  } catch (e) {
      return inputText; // Fail safe
  }
}