#!/bin/bash

APP_DIR="$HOME/.mac-ai-companion"
SERVICE_DIR="$HOME/Library/Services"
REPO_BASE="https://raw.githubusercontent.com/AniruddhaChattopadhyay/ai-shortcuts/main"

echo "✨ Installing Mac AI Shortcuts..."
echo ""

# 1. Create the hidden directory
mkdir -p "$APP_DIR"

# 2. Ask for OpenAI API Key
echo "Please enter your OpenAI API Key (sk-...):"
read -r API_KEY < /dev/tty
echo "✓ API Key saved"

# 3. Ask for Model Selection
echo ""
echo "Choose your AI model:"
echo "  1) gpt-5.2         - Latest, most capable (recommended)"
echo "  2) gpt-5-mini      - Fast and cost-efficient"
echo "  3) gpt-5-nano      - Fastest and most affordable (default)"
echo "  4) gpt-4o          - Previous generation, reliable"
echo ""
echo -n "Enter your choice (1-4) [default: 3]: "
read -r MODEL_CHOICE < /dev/tty

case "$MODEL_CHOICE" in
    1) MODEL="gpt-5.2" ;;
    2) MODEL="gpt-5-mini" ;;
    4) MODEL="gpt-4o" ;;
    *) MODEL="gpt-5-nano" ;;
esac

echo "{\"api_key\": \"$API_KEY\", \"model\": \"$MODEL\"}" > "$APP_DIR/config.json"
echo "✓ Using model: $MODEL"

# 4. Download all AI scripts
echo ""
echo "Downloading AI scripts..."
SCRIPTS=(
    "rewrite.js"
    "summarize.js"
    "fix-grammar.js"
    "make-casual.js"
    "make-shorter.js"
    "expand.js"
    "translate.js"
    "explain-simply.js"
    "reply.js"
)

for script in "${SCRIPTS[@]}"; do
    curl -sL "$REPO_BASE/scripts/$script" -o "$APP_DIR/$script"
    echo "  ✓ $script"
done

# 5. Download and Install all Service Workflows
echo ""
echo "Installing Quick Actions..."
curl -sL "$REPO_BASE/all-workflows.zip" -o "$APP_DIR/workflows.zip"

# Unzip into the Services folder
unzip -o -q "$APP_DIR/workflows.zip" -d "$SERVICE_DIR"
rm "$APP_DIR/workflows.zip"

echo "  ✓ AI Rewrite"
echo "  ✓ AI Summarize"
echo "  ✓ AI Fix Grammar"
echo "  ✓ AI Make Casual"
echo "  ✓ AI Make Shorter"
echo "  ✓ AI Expand"
echo "  ✓ AI Translate"
echo "  ✓ AI Explain Simply"
echo "  ✓ AI Reply"

echo ""
echo "✅ Installation Complete!"
echo ""
echo "📋 Available shortcuts (Right Click → Services):"
echo "   • AI Rewrite      - Make text professional"
echo "   • AI Summarize    - Condense into key points"
echo "   • AI Fix Grammar  - Fix spelling & grammar"
echo "   • AI Make Casual  - Friendly, informal tone"
echo "   • AI Make Shorter - Condense text"
echo "   • AI Expand       - Add more detail"
echo "   • AI Translate    - English ↔ Spanish"
echo "   • AI Explain Simply - Simplify complex text"
echo "   • AI Reply        - Draft a response"
echo ""
echo "💡 First time? Grant permissions in System Settings → Privacy & Security → Automation"
