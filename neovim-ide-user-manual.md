# Neovim IDE User Manual

## Table of Contents
1. [Getting Started](#getting-started)
2. [Basic Navigation](#basic-navigation)
3. [File Management](#file-management)
4. [Code Editing](#code-editing)
5. [Language Support & LSP](#language-support--lsp)
6. [Git Integration](#git-integration)
7. [GitHub Integration](#github-integration)
8. [AI-Powered Coding](#ai-powered-coding)
9. [Search & Find](#search--find)
10. [Autocompletion](#autocompletion)
11. [Debugging & Diagnostics](#debugging--diagnostics)
12. [Customization](#customization)

---

## Getting Started

### Launching Neovim
```bash
nvim                    # Open in current directory
nvim filename.py        # Open specific file
nvim .                  # Open with file explorer
```

### First Time Setup
1. Start Neovim - it will automatically install all plugins
2. Set your Claude API key: `export ANTHROPIC_API_KEY="your-key"`
3. Restart Neovim after installation completes

### Essential Keys
- **Leader Key**: `<Space>` (your main command key)
- **Help**: `<Space>` then wait - which-key will show available commands
- **Exit**: `:q` or `:qa` (quit all)
- **Save**: `<Ctrl-s>` or `:w`

---

## Basic Navigation

### Moving Around
```
h j k l             # Left, Down, Up, Right (basic vim)
w b                 # Forward/backward by word
0 $                 # Beginning/end of line
gg G                # Top/bottom of file
<Ctrl-u> <Ctrl-d>   # Page up/down
```

### Window Management
```
<Ctrl-h>            # Go to left window
<Ctrl-j>            # Go to lower window  
<Ctrl-k>            # Go to upper window
<Ctrl-l>            # Go to right window

<Ctrl-Up>           # Increase window height
<Ctrl-Down>         # Decrease window height
<Ctrl-Left>         # Decrease window width
<Ctrl-Right>        # Increase window width

:split              # Horizontal split
:vsplit             # Vertical split
```

### Moving Lines
```
<Alt-j>             # Move current line down
<Alt-k>             # Move current line up
```

---

## File Management

### File Explorer (nvim-tree)
```
<leader>ee          # Toggle file explorer
<leader>ef          # Find current file in explorer
<leader>ec          # Collapse all folders
<leader>er          # Refresh explorer
```

**Within the file explorer:**
```
<Enter>             # Open file/folder
o                   # Open file
a                   # Create new file
A                   # Create new folder
r                   # Rename file/folder
d                   # Delete file/folder
x                   # Cut file/folder
c                   # Copy file/folder
p                   # Paste file/folder
```

---

## Code Editing

### Basic Editing
```
i                   # Insert mode
a                   # Insert after cursor
o                   # New line below
O                   # New line above
<Esc>               # Exit insert mode

u                   # Undo
<Ctrl-r>            # Redo
.                   # Repeat last command
```

### Selection & Visual Mode
```
v                   # Visual mode (character)
V                   # Visual line mode
<Ctrl-v>            # Visual block mode

y                   # Copy (yank)
d                   # Cut (delete)
p                   # Paste
```

### Advanced Selection
```
<Ctrl-Space>        # Start incremental selection
<c-s>               # Expand to scope
<M-Space>           # Shrink selection
```

### Text Objects
```
af                  # Around function
if                  # Inside function
ac                  # Around class
ic                  # Inside class
aa                  # Around parameter
ia                  # Inside parameter
```

---

## Language Support & LSP

Your IDE supports: **Lua, C/C++, Python, Go, JavaScript/TypeScript, Java, Rust, Kotlin**

### Code Intelligence
```
gd                  # Go to definition
gr                  # Go to references
gI                  # Go to implementation
gD                  # Go to declaration
K                   # Hover documentation
<Ctrl-k>            # Signature help

<leader>rn          # Rename symbol
<leader>ca          # Code actions
<leader>D           # Type definition
```

### Workspace Navigation
```
<leader>ds          # Document symbols
<leader>ws          # Workspace symbols
<leader>wa          # Add workspace folder
<leader>wr          # Remove workspace folder
<leader>wl          # List workspace folders
```

### Formatting
```
:Format             # Format current buffer
```

---

## Git Integration

### Git Status & Operations (Fugitive)
```
<leader>gs          # Git status (interactive)
<leader>gb          # Git blame
<leader>gd          # Git diff split
<leader>gl          # Git log
```

**In Git status window:**
```
s                   # Stage file under cursor
u                   # Unstage file
cc                  # Commit
ca                  # Commit amend
```

### Git Hunks (Gitsigns)
```
]c                  # Next git hunk
[c                  # Previous git hunk

<leader>hs          # Stage hunk
<leader>hr          # Reset hunk
<leader>hS          # Stage buffer
<leader>hR          # Reset buffer
<leader>hp          # Preview hunk
<leader>hb          # Blame line
<leader>tb          # Toggle line blame
<leader>hd          # Diff against index
<leader>hD          # Diff against last commit
```

### Git Worktrees
```
<leader>gww         # List git worktrees
<leader>gwc         # Create git worktree
```

---

## GitHub Integration

### GitHub Operations (Octo)
```
<leader>ghi         # List GitHub issues
<leader>ghp         # List GitHub pull requests
<leader>ghr         # View repository
```

### Issue Management
```
:Octo issue create  # Create new issue
:Octo issue edit    # Edit current issue
:Octo issue close   # Close issue
:Octo issue list    # List issues
```

### Pull Request Management
```
:Octo pr create     # Create PR
:Octo pr edit       # Edit PR
:Octo pr merge      # Merge PR
:Octo pr checks     # View PR checks
:Octo pr diff       # View PR diff
```

---

## AI-Powered Coding (Avante)

### Setup
First, set your API key:
```bash
export ANTHROPIC_API_KEY="your-claude-api-key"
```

### AI Chat & Assistance
```
<leader>aa          # Open Avante chat sidebar
<leader>ae          # Edit selection with AI
<leader>ac          # Clear Avante chat
```

### Working with AI Suggestions
```
<Alt-l>             # Accept AI suggestion
<Alt-]>             # Next suggestion
<Alt-[>             # Previous suggestion
<Ctrl-]>            # Dismiss suggestion
```

### Diff Navigation
```
co                  # Apply our changes
ct                  # Apply AI changes (theirs)
ca                  # Apply all AI changes
cb                  # Apply both changes
cc                  # Apply at cursor
]x                  # Next conflict
[x                  # Previous conflict
```

### AI Workflow Examples
1. **Code Refactoring**: Select code → `<leader>ae` → "Refactor this to be more efficient"
2. **Bug Fixing**: Place cursor on error → `<leader>ae` → "Fix this bug"
3. **Code Generation**: `<leader>aa` → "Write a function to parse JSON"
4. **Documentation**: Select function → `<leader>ae` → "Add documentation"

---

## Search & Find

### File Finding (Telescope)
```
<leader>sf          # Search files
<leader>gf          # Search git files
<leader><space>     # Search open buffers
<leader>?           # Recently opened files
```

### Content Search
```
<leader>sg          # Live grep (search text)
<leader>sw          # Search current word
<leader>sG          # Grep in git root
<leader>/           # Search in current buffer
```

### LSP & Symbols
```
<leader>sd          # Search diagnostics
<leader>ds          # Document symbols
<leader>ws          # Workspace symbols
```

### Search Navigation
**In Telescope:**
```
<Ctrl-n>            # Next item
<Ctrl-p>            # Previous item
<Enter>             # Select item
<Esc>               # Close
<Ctrl-u>            # Clear input
```

---

## Autocompletion

### Using Completion
- Start typing - completion menu appears automatically
- `<Ctrl-n>` / `<Ctrl-p>` - Navigate suggestions
- `<Tab>` / `<Shift-Tab>` - Navigate and expand snippets
- `<Enter>` - Accept completion
- `<Ctrl-Space>` - Manually trigger completion

### Snippet Navigation
- `<Tab>` - Jump to next snippet placeholder
- `<Shift-Tab>` - Jump to previous placeholder

### Completion Sources
- **LSP**: Language server suggestions
- **Snippets**: Pre-defined code templates
- **Path**: File path completion

---

## Debugging & Diagnostics

### Viewing Diagnostics
```
[d                  # Previous diagnostic
]d                  # Next diagnostic
<leader>e           # Open diagnostic float
<leader>q           # Open diagnostics list
<leader>sd          # Search all diagnostics
```

### Error Navigation
- Red underlines = Errors
- Yellow underlines = Warnings
- Blue underlines = Info/Hints

### LSP Information
```
K                   # Hover documentation
<Ctrl-k>            # Signature help
```

---

## Advanced Workflows

### Project Development Workflow
1. **Open project**: `nvim .`
2. **Explore files**: `<leader>ee` (file tree) or `<leader>sf` (fuzzy find)
3. **Navigate code**: Use `gd`, `gr`, `K` for definitions, references, docs
4. **Edit with AI**: Select code → `<leader>ae` for AI assistance
5. **Search codebase**: `<leader>sg` for text search
6. **Git workflow**: `<leader>gs` for status, stage, commit

### Multi-File Editing
1. Open multiple files in splits: `:vsplit filename`
2. Navigate between windows: `<Ctrl-hjkl>`
3. Use buffers: `<leader><space>` to switch between open files

### Code Review Workflow
1. `<leader>gd` - View git diff
2. Navigate hunks: `]c` / `[c`
3. Stage changes: `<leader>hs`
4. Create PR: `:Octo pr create`

---

## Essential Keybinding Reference

### Most Used Commands
```
<Space>             # Leader key - shows available commands
<leader>sf          # Find files
<leader>sg          # Search text
<leader>ee          # Toggle file explorer
<leader>aa          # AI chat
<leader>ae          # AI edit selection
<leader>gs          # Git status
gd                  # Go to definition
K                   # Show documentation
<Ctrl-s>            # Save file
```

### Quick Actions
```
<leader>ca          # Code actions (fixes, refactors)
<leader>rn          # Rename symbol
<leader>e           # Show error details
<Ctrl-Space>        # Trigger completion
u                   # Undo
<Ctrl-r>            # Redo
```

---

## Language-Specific Features

### Java
- Full IDE experience with nvim-jdtls
- Automatic project detection
- Maven/Gradle support

### Python
- Type checking with Pyright
- Import sorting and formatting
- Virtual environment detection

### JavaScript/TypeScript
- Modern ES6+ support
- React/Vue component intelligence
- NPM integration

### Kotlin
- Full language server support
- Android development ready
- Gradle integration

### Go
- Go modules support
- Built-in formatting (gofmt)
- Testing integration

### Rust
- Cargo integration
- Macro expansion
- Advanced type inference

---

## Tips & Tricks

### Productivity Tips
1. **Use leader key extensively** - `<Space>` shows all available commands
2. **Master telescope** - `<leader>sf` and `<leader>sg` are your best friends
3. **Leverage AI** - Use `<leader>ae` for quick refactoring and improvements
4. **Git workflow** - `<leader>gs` for interactive staging and commits
5. **Quick documentation** - `K` on any symbol for instant docs

### Workflow Examples
1. **Finding and editing code**:
   - `<leader>sg` → search for function
   - `gd` → go to definition
   - `<leader>ae` → ask AI to improve it

2. **Code review**:
   - `<leader>gd` → see changes
   - `]c` / `[c` → navigate hunks
   - `<leader>hp` → preview changes

3. **Debugging errors**:
   - `]d` → jump to error
   - `<leader>e` → see error details
   - `<leader>ca` → see available fixes

---

## Troubleshooting

### Common Issues
1. **LSP not working**: Check `:LspInfo` and ensure language servers are installed
2. **AI not working**: Verify `ANTHROPIC_API_KEY` environment variable
3. **Slow performance**: Restart Neovim or check `:checkhealth`
4. **Plugin errors**: Run `:Lazy sync` to update plugins

### Health Checks
```
:checkhealth        # Overall system health
:LspInfo            # LSP server status
:Lazy               # Plugin manager status
```

---

## Quick Reference Card

### Essential Shortcuts
| Action | Key | Description |
|--------|-----|-------------|
| Command palette | `<Space>` | Show available commands |
| Find files | `<leader>sf` | Fuzzy file finder |
| Search text | `<leader>sg` | Live grep search |
| File explorer | `<leader>ee` | Toggle file tree |
| AI chat | `<leader>aa` | Open AI assistant |
| AI edit | `<leader>ae` | Edit with AI |
| Git status | `<leader>gs` | Interactive git |
| Go to definition | `gd` | Jump to definition |
| Show docs | `K` | Hover documentation |
| Code actions | `<leader>ca` | Available fixes |
| Rename | `<leader>rn` | Rename symbol |
| Save | `<Ctrl-s>` | Save current file |
| Undo/Redo | `u` / `<Ctrl-r>` | Undo/redo changes |

### Navigation Shortcuts
| Action | Key | Description |
|--------|-----|-------------|
| Next error | `]d` | Jump to next diagnostic |
| Previous error | `[d` | Jump to previous diagnostic |
| Next git hunk | `]c` | Next git change |
| Previous git hunk | `[c` | Previous git change |
| Next function | `]m` | Jump to next function |
| Previous function | `[m` | Jump to previous function |

---

## Advanced Features

### Multiple Cursors & Editing
```
<Ctrl-v>            # Visual block mode
I                   # Insert at beginning of all lines
A                   # Insert at end of all lines
```

### Folding
```
zf                  # Create fold
zo                  # Open fold
zc                  # Close fold
za                  # Toggle fold
```

### Macros
```
qa                  # Record macro 'a'
q                   # Stop recording
@a                  # Execute macro 'a'
@@                  # Repeat last macro
```

### Registers
```
"ay                 # Yank to register 'a'
"ap                 # Paste from register 'a'
:reg                # Show all registers
```

---

## Daily Workflow Examples

### Starting a New Feature
1. `nvim .` - Open project
2. `<leader>gs` - Check git status
3. `<leader>sf` - Find relevant files
4. `<leader>aa` - Ask AI about implementation approach
5. Start coding with LSP assistance

### Debugging Issues
1. `]d` - Jump to first error
2. `<leader>e` - See error details
3. `K` - Check documentation
4. `<leader>ca` - See available fixes
5. `<leader>ae` - Ask AI for help

### Code Review
1. `<leader>gd` - View changes
2. `]c` / `[c` - Navigate through changes
3. `<leader>hp` - Preview each hunk
4. `<leader>hs` - Stage good changes
5. `<leader>gs` - Commit staged changes

### Refactoring Code
1. Select code block in visual mode
2. `<leader>ae` - Ask AI to refactor
3. Review suggested changes
4. `co` / `ct` - Apply changes
5. Test and commit

---

## Configuration Locations

### Main Config Files
```
~/.config/nvim/init.lua                 # Main entry point
~/.config/nvim/lua/config/options.lua   # Editor settings
~/.config/nvim/lua/config/keymaps.lua   # Custom keybindings
~/.config/nvim/lua/plugins/             # All plugin configurations
```

### Important Plugin Files
```
plugins/lsp.lua         # Language server configuration
plugins/telescope.lua   # File finder and search
plugins/avante.lua      # AI integration
plugins/treesitter.lua  # Syntax highlighting
plugins/gitsigns.lua    # Git integration
```

---

## Performance Tips

### Speed Up Startup
- Plugins are lazy-loaded by default
- Use `:Lazy profile` to check startup time

### Memory Usage
- Close unused buffers: `:bd`
- Clear search highlighting: `<Esc>`

### Large Files
- Use `:set syntax=off` for very large files
- Consider using `view` mode: `nvim -R largefile.txt`

---

## Getting Help

### Built-in Help
```
:help               # General help
:help <command>     # Help for specific command
:help <plugin>      # Plugin documentation
<Space>             # Which-key shows available commands
```

### Plugin Status
```
:Lazy               # Plugin manager
:LspInfo            # LSP status
:checkhealth        # System diagnostics
:Mason              # LSP installer status
```

### Community Resources
- Neovim docs: https://neovim.io/doc/
- Plugin repos on GitHub
- r/neovim community

---

## Customization

### Adding Your Own Keybindings
Edit `~/.config/nvim/lua/config/keymaps.lua`:
```lua
vim.keymap.set("n", "<leader>custom", ":echo 'Hello'<CR>", { desc = "Custom command" })
```

### Adding New Plugins
Create new file in `~/.config/nvim/lua/plugins/`:
```lua
return {
  'author/plugin-name',
  config = function()
    -- Plugin configuration
  end,
}
```

### Changing Theme
Edit `~/.config/nvim/lua/plugins/ui.lua` and change the colorscheme setup.

---

## Emergency Commands

### When Things Go Wrong
```
:q!                 # Quit without saving
:e!                 # Reload file (lose changes)
:Lazy restore       # Restore plugin state
:LspRestart         # Restart language servers
```

### Reset Configuration
```bash
# Backup and reset
mv ~/.config/nvim ~/.config/nvim.backup
# Then reinstall from scratch
```

---

This manual covers the complete functionality of your Neovim IDE. Start with the essential shortcuts and gradually explore advanced features. The AI integration (`<leader>ae`) will be particularly helpful as you learn!