#!/bin/bash

echo "🗑 Uninstalling Mac AI Shortcuts..."
echo ""

# Remove the config and scripts directory
if [ -d "$HOME/.mac-ai-companion" ]; then
    rm -rf "$HOME/.mac-ai-companion"
    echo "✓ Removed ~/.mac-ai-companion"
else
    echo "- ~/.mac-ai-companion not found (already removed)"
fi

# Remove all AI workflow services
WORKFLOWS=(
    "AI Rewrite.workflow"
    "AI Summarize.workflow"
    "AI Fix Grammar.workflow"
    "AI Make Casual.workflow"
    "AI Make Shorter.workflow"
    "AI Expand.workflow"
    "AI Translate.workflow"
    "AI Explain Simply.workflow"
    "AI Reply.workflow"
)

echo ""
echo "Removing Quick Actions..."
for workflow in "${WORKFLOWS[@]}"; do
    if [ -d "$HOME/Library/Services/$workflow" ]; then
        rm -rf "$HOME/Library/Services/$workflow"
        echo "  ✓ Removed $workflow"
    fi
done

echo ""
echo "✅ Uninstalled successfully!"
