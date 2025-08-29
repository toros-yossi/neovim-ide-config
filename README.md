# Custom Neovim IDE Configuration

A complete Neovim IDE setup with LSP support, AI integration, and modern development tools.

## Features

### 🛠️ Language Support
- **Languages**: Lua, C/C++, Python, Go, JavaScript/TypeScript, Java, Rust, Kotlin
- **LSP Integration**: Full language server protocol support
- **Syntax Highlighting**: TreeSitter-powered highlighting
- **Auto-formatting**: Built-in code formatting

### 🤖 AI Integration
- **Claude Integration**: AI-powered code editing and chat via Avante.nvim
- **Inline Editing**: Select code and refactor with AI assistance
- **Code Generation**: AI-powered code suggestions and completions

### 📁 File Management
- **File Explorer**: nvim-tree with intuitive navigation
- **Fuzzy Finder**: Telescope for lightning-fast file and text search
- **Git Integration**: Visual git status, hunks, and operations

### 🔗 GitHub Integration
- **Issue Management**: Create, edit, and manage GitHub issues
- **Pull Requests**: Full PR workflow from within Neovim
- **Repository Operations**: Browse and manage repositories

## Installation

### Prerequisites
```bash
# Install Neovim
brew install neovim

# Set Claude API key
export ANTHROPIC_API_KEY="your-api-key-here"
```

### Setup
```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this repository
git clone <your-repo-url> ~/.config/nvim

# Launch Neovim (plugins will auto-install)
nvim
```

## Quick Start Guide

### Essential Keybindings
| Key | Action | Description |
|-----|--------|-------------|
| `<Space>` | Leader | Shows available commands |
| `<leader>sf` | Find Files | Fuzzy file finder |
| `<leader>sg` | Search Text | Live grep search |
| `<leader>ee` | File Explorer | Toggle file tree |
| `<leader>aa` | AI Chat | Open Claude assistant |
| `<leader>ae` | AI Edit | Edit selection with AI |
| `<leader>gs` | Git Status | Interactive git interface |
| `gd` | Go to Definition | Jump to symbol definition |
| `K` | Documentation | Show hover docs |

### Daily Workflow
1. **Open project**: `nvim .`
2. **Explore files**: `<leader>ee` or `<leader>sf`
3. **Search code**: `<leader>sg`
4. **Navigate code**: `gd`, `gr`, `K`
5. **Edit with AI**: Select code → `<leader>ae`
6. **Git workflow**: `<leader>gs` → stage → commit

## Configuration Structure

```
├── init.lua                    # Main entry point
├── lua/
│   ├── config/
│   │   ├── options.lua         # Editor settings
│   │   └── keymaps.lua         # Key bindings
│   └── plugins/
│       ├── lsp.lua             # Language server config
│       ├── telescope.lua       # File finder & search
│       ├── nvim-tree.lua       # File explorer
│       ├── treesitter.lua      # Syntax highlighting
│       ├── completion.lua      # Autocompletion
│       ├── gitsigns.lua        # Git integration
│       ├── github.lua          # GitHub integration
│       ├── avante.lua          # AI integration
│       └── ui.lua              # Theme & statusline
└── neovim-ide-user-manual.md   # Complete user guide
```

## Supported Languages

### LSP Servers Included
- **Lua**: lua_ls
- **C/C++**: clangd
- **Python**: pyright  
- **Go**: gopls
- **JavaScript/TypeScript**: ts_ls
- **Java**: jdtls
- **Rust**: rust_analyzer
- **Kotlin**: kotlin_language_server

### TreeSitter Parsers
All major languages plus JSON, YAML, HTML, CSS, Markdown

## Customization

### Adding New Languages
Edit `lua/plugins/lsp.lua` and add the language server to `ensure_installed`.

### Custom Keybindings
Add to `lua/config/keymaps.lua`:
```lua
vim.keymap.set("n", "<leader>custom", ":echo 'Hello'<CR>", { desc = "Custom command" })
```

### New Plugins
Create new file in `lua/plugins/`:
```lua
return {
  'author/plugin-name',
  config = function()
    -- Plugin setup
  end,
}
```

## Troubleshooting

### Common Issues
- **LSP not working**: Run `:LspInfo` and `:Mason` to check servers
- **AI not responding**: Verify `ANTHROPIC_API_KEY` environment variable
- **Plugin errors**: Run `:Lazy sync` to update plugins
- **Performance issues**: Run `:checkhealth` for diagnostics

### Health Checks
```
:checkhealth        # Overall system health
:LspInfo            # Language server status
:Lazy               # Plugin manager
:Mason              # LSP installer
```

## Documentation

See `neovim-ide-user-manual.md` for complete usage instructions and workflows.

## Contributing

Feel free to customize and extend this configuration for your needs!

## License

MIT License - Feel free to use and modify as needed.