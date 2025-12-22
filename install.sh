#!/bin/bash

APP_DIR="$HOME/.mac-ai-companion"
SERVICE_DIR="$HOME/Library/Services"
REPO_BASE="https://raw.githubusercontent.com/AniruddhaChattopadhyay/ai-shortcuts/main"

echo "✨ Installing Mac AI Shortcuts..."
echo ""

# 1. Create the hidden directory
mkdir -p "$APP_DIR"

# 2. Ask for AI Provider
echo "Choose your AI provider:"
echo "  1) OpenAI      - GPT-5.2, GPT-5-nano, GPT-4o"
echo "  2) Anthropic   - Claude Sonnet 4.5, Claude Sonnet 4, Claude Haiku 4"
echo "  3) Google      - Gemini 2.5 Flash, Gemini 2.0 Flash"
echo ""
echo -n "Enter your choice (1-3) [default: 1]: "
read -r PROVIDER_CHOICE < /dev/tty

case "$PROVIDER_CHOICE" in
    2) PROVIDER="anthropic" ;;
    3) PROVIDER="gemini" ;;
    *) PROVIDER="openai" ;;
esac

echo "✓ Using provider: $PROVIDER"
echo ""

# 3. Ask for API Key based on provider
case "$PROVIDER" in
    "openai")
        echo "Please enter your OpenAI API Key (sk-...):"
        ;;
    "anthropic")
        echo "Please enter your Anthropic API Key (sk-ant-...):"
        ;;
    "gemini")
        echo "Please enter your Google AI API Key:"
        ;;
esac
read -r API_KEY < /dev/tty
echo "✓ API Key saved"
echo ""

# 4. Ask for Model Selection based on provider
echo "Choose your AI model:"

case "$PROVIDER" in
    "openai")
        echo "  1) gpt-5.2         - Latest, most capable"
        echo "  2) gpt-5-mini      - Fast and efficient"
        echo "  3) gpt-5-nano      - Fastest and affordable (default)"
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
        ;;
    "anthropic")
        echo "  1) claude-sonnet-4-5-20250929 - Latest Sonnet 4.5, most capable (default)"
        echo "  2) claude-sonnet-4-20250514   - Sonnet 4, balanced"
        echo "  3) claude-haiku-4-5-20251001  - Haiku 4.5, fastest"
        echo ""
        echo -n "Enter your choice (1-3) [default: 1]: "
        read -r MODEL_CHOICE < /dev/tty
        case "$MODEL_CHOICE" in
            2) MODEL="claude-sonnet-4-20250514" ;;
            3) MODEL="claude-haiku-4-5-20251001" ;;
            *) MODEL="claude-sonnet-4-5-20250929" ;;
        esac
        ;;
    "gemini")
        echo "  1) gemini-2.5-flash       - Latest, fast (default)"
        echo "  2) gemini-2.5-flash-lite  - Fast and cost-efficient"
        echo "  3) gemini-2.0-flash       - Reliable, proven"
        echo "  4) gemini-2.0-flash-lite  - Budget-friendly"
        echo ""
        echo -n "Enter your choice (1-4) [default: 1]: "
        read -r MODEL_CHOICE < /dev/tty
        case "$MODEL_CHOICE" in
            2) MODEL="gemini-2.5-flash-lite" ;;
            3) MODEL="gemini-2.0-flash" ;;
            4) MODEL="gemini-2.0-flash-lite" ;;
            *) MODEL="gemini-2.5-flash" ;;
        esac
        ;;
esac

# Save config with provider info
echo "{\"provider\": \"$PROVIDER\", \"api_key\": \"$API_KEY\", \"model\": \"$MODEL\"}" > "$APP_DIR/config.json"
echo "✓ Using model: $MODEL"

# 5. Download all AI scripts
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

# 6. Download and Install all Service Workflows
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
echo "📋 Provider: $PROVIDER | Model: $MODEL"
echo ""
echo "📋 Available shortcuts (Right Click → Services):"
echo "   • AI Rewrite      - Make text professional"
echo "   • AI Summarize    - Condense into key points"
echo "   • AI Fix Grammar  - Fix spelling & grammar"
echo "   • AI Make Casual  - Friendly, informal tone"
echo "   • AI Make Shorter - Condense text"
echo "   • AI Expand       - Add more detail"
echo "   • AI Translate    - Translate to English"
echo "   • AI Explain Simply - Simplify complex text"
echo "   • AI Reply        - Draft a response"
echo ""
echo "💡 First time? Grant permissions in System Settings → Privacy & Security → Automation"
