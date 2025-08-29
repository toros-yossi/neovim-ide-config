#!/bin/bash

echo "🚀 Installing Custom Neovim IDE Configuration..."

# Check if Neovim is installed
if ! command -v nvim &> /dev/null; then
    echo "❌ Neovim not found. Installing via Homebrew..."
    if command -v brew &> /dev/null; then
        brew install neovim
    else
        echo "❌ Homebrew not found. Please install Neovim manually."
        exit 1
    fi
fi

# Backup existing config
if [ -d "$HOME/.config/nvim" ]; then
    echo "📦 Backing up existing Neovim config to ~/.config/nvim.backup"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup"
fi

# Create config directory
mkdir -p "$HOME/.config"

# Copy configuration
echo "📋 Installing Neovim configuration..."
cp -r "$(dirname "$0")" "$HOME/.config/nvim"

# Remove git files from config directory
rm -rf "$HOME/.config/nvim/.git"
rm -f "$HOME/.config/nvim/install.sh"
rm -f "$HOME/.config/nvim/README.md"
rm -f "$HOME/.config/nvim/.gitignore"

echo "✅ Configuration installed successfully!"
echo ""
echo "🔑 Don't forget to set your Claude API key:"
echo "export ANTHROPIC_API_KEY=\"your-api-key-here\""
echo ""
echo "🎉 Launch Neovim with: nvim"
echo "   Plugins will auto-install on first run!"