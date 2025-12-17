#!/bin/bash

echo "🗑 Uninstalling Mac AI Companion..."

# Remove the config and logic directory
if [ -d "$HOME/.mac-ai-companion" ]; then
    rm -rf "$HOME/.mac-ai-companion"
    echo "✓ Removed ~/.mac-ai-companion"
else
    echo "- ~/.mac-ai-companion not found (already removed)"
fi

# Remove the Service workflow
if [ -d "$HOME/Library/Services/AI Rewrite.workflow" ]; then
    rm -rf "$HOME/Library/Services/AI Rewrite.workflow"
    echo "✓ Removed AI Rewrite.workflow"
else
    echo "- AI Rewrite.workflow not found (already removed)"
fi

echo ""
echo "✅ Uninstalled successfully!"
