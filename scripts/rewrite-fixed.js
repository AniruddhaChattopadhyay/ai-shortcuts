#!/usr/bin/env osascript -l JavaScript

function run(argv) {
  var app = Application.currentApplication();
  app.includeStandardAdditions = true;

  var inputText = argv[0];
  if (!inputText) return;

  var home = app.systemAttribute('HOME');
  var configPath = home + "/.mac-ai-companion/config.json";

  try {
    var configStr = app.read(Path(configPath));
    var config = JSON.parse(configStr);
    var apiKey = config.api_key;
    var model = config.model || "gpt-5-nano";
  } catch (e) {
    return "Error: Could not read API Key. Please reinstall.";
  }

  var payload = {
    "model": model,
    "messages": [
      { "role": "system", "content": "Rewrite the user's text to be clear, professional, and concise. Only output the rewritten text." },
      { "role": "user", "content": inputText }
    ]
  };

  var strPayload = JSON.stringify(payload);

  // Use echo with proper escaping instead of writing to file
  var escapedPayload = strPayload.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/'/g, "'\\''");
  var curlCommand = 'echo \'' + escapedPayload + '\' | curl -s -X POST https://api.openai.com/v1/chat/completions ' +
    '-H "Content-Type: application/json; charset=utf-8" ' +
    '-H "Authorization: Bearer ' + apiKey + '" ' +
    '-d @-';

  try {
    var response = app.doShellScript(curlCommand);
    var json = JSON.parse(response);

    if (json.choices && json.choices.length > 0) {
      return json.choices[0].message.content;
    } else {
      return inputText;
    }
  } catch (e) {
    return inputText;
  }
}
