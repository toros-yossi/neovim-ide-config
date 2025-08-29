# Neovim IDE Configuration Project

## Project Overview
This is a comprehensive Neovim IDE configuration designed for multi-language development with modern tooling, AI integration, and professional workflows.

## Architecture & Technology Stack

### Core Framework
- **Package Manager**: lazy.nvim with modular plugin structure
- **Configuration Structure**: Lua-based with separated concerns (config/, plugins/)
- **Bootstrap**: Automatic lazy.nvim installation and plugin management

### Language Support
**Always Available:**
- Lua (lua_ls) - Built-in Neovim support
- Python (pyright) - Uses system Python
- JavaScript/TypeScript (ts_ls) - Uses Node.js
- Java (jdtls) - Managed by nvim-jdtls plugin
- Kotlin (kotlin_language_server)

**Conditional (requires external tools):**
- Go (gopls) - Requires `go` command
- Rust (rust_analyzer) - Requires `rustc` command  
- C/C++ (clangd) - Requires `clang` or `gcc`

### Key Features Implemented

#### Multi-Language Development
- LSP integration with mason.nvim for automatic server installation
- TreeSitter for syntax highlighting and code parsing
- Conditional LSP installation based on system tool availability
- Language-specific configurations and optimizations

#### Python Environment Management
- Poetry integration with automatic environment detection
- uv support for modern Python package management
- Virtual environment auto-detection and switching
- Python-specific testing and debugging configurations

#### Testing & Debugging
- neotest integration with adapters for all supported languages
- Debug Adapter Protocol (DAP) with nvim-dap
- Language-specific test runners (pytest, jest, cargo test, go test)
- Interactive debugging UI with breakpoints and variable inspection

#### Multi-Project Workspace Management
- Auto-detection of git repositories in parent directories
- Pattern-based project discovery (pyproject.toml, package.json, etc.)
- Workspace folder management for related projects
- Cross-project navigation and search capabilities

#### AI Integration (Claude Code)
- Full conversational AI experience with session management
- Context-aware Claude integration:
  - Interactive sessions (`<leader>cc`)
  - Session continuation (`<leader>cr`) 
  - File context (`<leader>cf`)
  - Selection context (`<leader>cs`)
  - Project context (`<leader>cp`)
- Replaced basic --print approach with true conversational interface

#### Task Management
- Taskfile.yml support with task discovery and execution
- Integration with project-specific build systems
- Quick access to common tasks (build, test, dev, start)

#### Git & GitHub Integration
- Advanced git operations with vim-fugitive
- GitHub issue and PR management with octo.nvim
- Git worktree support for parallel development
- Visual git status and diff capabilities

## File Structure
```
├── init.lua                    # Bootstrap entry point
├── lua/
│   ├── config/
│   │   ├── options.lua         # Editor settings
│   │   ├── keymaps.lua         # Key bindings & Claude integration
│   │   └── multi-project.lua   # Workspace management
│   └── plugins/
│       ├── lsp.lua             # Language servers (conditional)
│       ├── telescope.lua       # Fuzzy finding
│       ├── nvim-tree.lua       # File explorer
│       ├── treesitter.lua      # Syntax highlighting
│       ├── completion.lua      # nvim-cmp autocompletion
│       ├── gitsigns.lua        # Git integration
│       ├── github.lua          # GitHub workflow
│       ├── testing.lua         # neotest configuration
│       ├── debugging.lua       # DAP configuration
│       ├── python.lua          # Python environment management
│       ├── taskfile.lua        # Task runner integration
│       └── ui.lua              # Theme & statusline
├── README.md                   # User documentation
└── CLAUDE.md                   # This file - project memory
```

## Key Design Decisions

### Conditional LSP Installation
- LSP servers are only installed if their dependencies are available
- Prevents installation failures and improves user experience
- Uses `vim.fn.executable()` checks for tool availability

### Modular Plugin Architecture
- Each plugin category in separate files for maintainability
- Lazy loading for optimal startup performance
- Plugin-specific configurations contained within plugin definitions

### Multi-Project Support Philosophy
- Assumes users work with related projects (like Sentra ecosystem)
- Auto-discovery reduces manual workspace management
- Cross-project search and navigation as primary workflow

### AI Integration Approach
- Full conversational experience over one-off questions
- Session persistence for continued development context
- Multiple context options (file, selection, project) for flexibility
- Terminal-based integration for universal compatibility

## Recent Improvements

### Enhanced Claude Integration (Latest)
- Replaced basic `claude --print` with interactive sessions
- Added session continuation capabilities
- Implemented context-aware Claude workflows
- Updated documentation with usage examples and cross-IDE information

## Development Workflow Patterns

### Daily Usage
1. Open project with `nvim .`
2. Add related projects with `<leader>wag` or `<leader>wap`
3. Use AI assistance with `<leader>cc` (new) or `<leader>cr` (continue)
4. Navigate and search across workspace with telescope
5. Run tests and debug with integrated tools

### Multi-Project Development
- Workspace automatically detects related projects
- LSP and search work across all workspace folders
- Git operations can span multiple repositories
- AI context can include entire workspace

## Testing & Quality Assurance
- All language-specific features have corresponding test configurations
- Debugging capabilities for each supported language
- Linting and formatting integrated into development workflow
- CI-ready with proper error handling and conditional installations

## CRITICAL: Testing Requirements
**ALWAYS test changes before committing:**
- Run Neovim with `nvim .` to verify configuration loads without errors
- Test key bindings and plugin functionality
- Check LSP servers install and function correctly
- Verify conditional features work based on available tools
- Test Claude integration with actual sessions
- Confirm multi-project workspace detection works
- Validate testing and debugging capabilities for relevant languages
- **NEVER commit without testing - broken configs affect user productivity**

## When to Update CLAUDE.md

**MUST update this file when:**
- Adding new language support or LSP servers
- Changing core architecture or design decisions
- Adding/removing major features or plugins
- Modifying key bindings or workflows significantly
- Changing file structure or organization
- Adding new dependencies or requirements
- Updating AI integration or session management
- Changing testing or debugging configurations
- Adding new workflow patterns or usage scenarios
- Making breaking changes that affect user experience

**SHOULD update when:**
- Optimizing existing features significantly
- Adding new utility functions or helper modules
- Updating plugin configurations with new options
- Improving error handling or conditional logic
- Adding new documentation or README sections

**NO need to update for:**
- Minor bug fixes that don't change functionality
- Small refactoring without behavior changes
- Typo fixes in comments or documentation
- Version updates of existing plugins (unless breaking)
- Minor performance optimizations
- Cosmetic changes to UI or themes

**Update Guidelines:**
- Always update "Recent Improvements" section for major changes
- Add new features to appropriate sections
- Update file structure if files are added/removed/renamed
- Modify design decisions if architectural changes occur
- Keep testing requirements current with new features

## Future Enhancement Areas
- Additional language support as needed
- Enhanced AI integration features
- Improved multi-project synchronization
- Performance optimizations for large workspaces

## Usage Notes for Claude
- This configuration is actively maintained and evolving
- Focus on maintaining modularity and conditional feature detection
- Consider cross-platform compatibility (macOS primary, Linux secondary)
- Document breaking changes and migration paths
- Test language features only if tools are available in environment