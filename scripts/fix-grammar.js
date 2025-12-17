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
  } catch (e) {
    return "Error: Could not read API Key. Please reinstall.";
  }

  var payload = {
    "model": "gpt-4o-mini",
    "messages": [
      { "role": "system", "content": "Fix any spelling, grammar, and punctuation errors in the user's text. Keep the original tone and meaning. Only output the corrected text." },
      { "role": "user", "content": inputText }
    ]
  };

  var tempFile = "/tmp/ai_request_" + (Math.floor(Math.random() * 10000)) + ".json";
  var strPayload = JSON.stringify(payload);

  var file = app.openForAccess(Path(tempFile), { writePermission: true });
  app.setEof(file, { to: 0 });
  app.write(strPayload, { to: file, startingAt: 0 });
  app.closeAccess(file);

  var curlCommand = 'curl -s -X POST https://api.openai.com/v1/chat/completions ' +
    '-H "Content-Type: application/json" ' +
    '-H "Authorization: Bearer ' + apiKey + '" ' +
    '-d @' + tempFile;

  try {
    var response = app.doShellScript(curlCommand);
    var json = JSON.parse(response);
    app.doShellScript('rm ' + tempFile);

    if (json.choices && json.choices.length > 0) {
      return json.choices[0].message.content;
    } else {
      return inputText;
    }
  } catch (e) {
    return inputText;
  }
}
