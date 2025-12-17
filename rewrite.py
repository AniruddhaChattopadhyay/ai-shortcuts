#!/usr/bin/env python3
import sys
import json
import urllib.request
import os

# 1. Get the API Key (stored during installation)
CONFIG_PATH = os.path.expanduser("~/.mac-ai-companion/config.json")

try:
    with open(CONFIG_PATH, 'r') as f:
        config = json.load(f)
        api_key = config.get("api_key")
except FileNotFoundError:
    print("Error: API Key not found. Please reinstall.")
    sys.exit(1)

# 2. Read the selected text passed from macOS
input_text = sys.stdin.read().strip()
if not input_text:
    sys.exit(0)

# 3. Prepare the OpenAI Request
url = "https://api.openai.com/v1/chat/completions"
headers = {
    "Content-Type": "application/json",
    "Authorization": f"Bearer {api_key}"
}
data = {
    "model": "gpt-4o-mini",
    "messages": [
        {"role": "system", "content": "You are a helpful writing assistant. Rewrite the user's text to be clear, professional, and concise. Only output the rewritten text, nothing else."},
        {"role": "user", "content": input_text}
    ]
}

# 4. Send Request
try:
    req = urllib.request.Request(url, json.dumps(data).encode(), headers)
    with urllib.request.urlopen(req) as response:
        res_body = response.read()
        result = json.loads(res_body)
        # 5. Output the result (This replaces the selected text)
        print(result['choices'][0]['message']['content'].strip())
except Exception as e:
    # If it fails, just print the original text so nothing is lost
    print(input_text)