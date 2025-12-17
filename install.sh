#!/bin/bash

APP_DIR="$HOME/.mac-ai-companion"
SERVICE_DIR="$HOME/Library/Services"

echo "✨ Installing Mac AI Companion..."

# 1. Create the hidden directory
mkdir -p "$APP_DIR"

# 2. Ask for OpenAI API Key
echo "Please enter your OpenAI API Key (sk-...):"
read -r API_KEY < /dev/tty
# Save it to a JSON config
echo "{\"api_key\": \"$API_KEY\"}" > "$APP_DIR/config.json"

# 3. Download the Python Logic (assuming you host it on GitHub)
# (During development, you can just copy it, but for the final script use curl)
echo "Downloading logic..."
curl -sL "https://raw.githubusercontent.com/AniruddhaChattopadhyay/ai-shortcuts/main/rewrite.js" -o "$APP_DIR/rewrite.js"

# 4. Download and Install the Service Workflow
echo "Installing Service..."
curl -sL "https://raw.githubusercontent.com/AniruddhaChattopadhyay/ai-shortcuts/main/AI%20Rewrite.workflow.zip" -o "$APP_DIR/service.zip"

# Unzip into the Services folder
unzip -o -q "$APP_DIR/service.zip" -d "$SERVICE_DIR"
rm "$APP_DIR/service.zip"

echo "✅ Installation Complete!"
echo "You may need to give permissions the first time you run it."
echo "Try selecting text in any app, Right Click > Services > AI Rewrite"