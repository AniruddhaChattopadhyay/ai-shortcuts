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
    var provider = config.provider || "openai";
    var apiKey = config.api_key;
    var model = config.model || "gpt-5-nano";
  } catch (e) {
    return "Error: Could not read config. Please reinstall.";
  }

  var systemPrompt = "If the text is not in English, translate it to English. If the text is already in English, return it exactly as is without any changes. Only output the text, nothing else.";
  var tempFile = "/tmp/ai_request_" + (Math.floor(Math.random() * 10000)) + ".json";
  var curlCommand = "";
  var payload = {};

  if (provider === "openai") {
    payload = {
      "model": model,
      "messages": [
        { "role": "system", "content": systemPrompt },
        { "role": "user", "content": inputText }
      ]
    };
    curlCommand = 'curl -s -X POST https://api.openai.com/v1/chat/completions ' +
      '-H "Content-Type: application/json; charset=utf-8" ' +
      '-H "Authorization: Bearer ' + apiKey + '" ' +
      '-d @' + tempFile;
  } else if (provider === "anthropic") {
    payload = {
      "model": model,
      "max_tokens": 4096,
      "system": systemPrompt,
      "messages": [
        { "role": "user", "content": inputText }
      ]
    };
    curlCommand = 'curl -s -X POST https://api.anthropic.com/v1/messages ' +
      '-H "Content-Type: application/json; charset=utf-8" ' +
      '-H "x-api-key: ' + apiKey + '" ' +
      '-H "anthropic-version: 2023-06-01" ' +
      '-d @' + tempFile;
  } else if (provider === "gemini") {
    payload = {
      "systemInstruction": {
        "parts": [{ "text": systemPrompt }]
      },
      "contents": [
        {
          "parts": [{ "text": inputText }]
        }
      ]
    };
    curlCommand = 'curl -s -X POST "https://generativelanguage.googleapis.com/v1beta/models/' + model + ':generateContent?key=' + apiKey + '" ' +
      '-H "Content-Type: application/json; charset=utf-8" ' +
      '-d @' + tempFile;
  }

  var strPayload = JSON.stringify(payload);

  // Use shell printf which handles UTF-8 correctly
  var escapedPayload = strPayload.replace(/'/g, "'\\''");
  var writeCmd = "printf '%s' '" + escapedPayload + "' > " + tempFile;

  try {
    app.doShellScript(writeCmd);
  } catch (e) {
    return "Error writing file";
  }

  try {
    var response = app.doShellScript(curlCommand);
    var json = JSON.parse(response);
    app.doShellScript('rm ' + tempFile);

    // Parse response based on provider
    if (provider === "openai") {
      if (json.choices && json.choices.length > 0) {
        return json.choices[0].message.content;
      }
    } else if (provider === "anthropic") {
      if (json.content && json.content.length > 0) {
        return json.content[0].text;
      }
    } else if (provider === "gemini") {
      if (json.candidates && json.candidates.length > 0) {
        return json.candidates[0].content.parts[0].text;
      }
    }
    return inputText;
  } catch (e) {
    return inputText;
  }
}
