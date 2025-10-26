# Neovim Configuration

This module provides a comprehensive Neovim setup with LazyVim as the base configuration and additional customizations for an enhanced development experience.

## Overview

The configuration is built on top of [LazyVim](https://github.com/LazyVim/LazyVim), a Neovim configuration framework that provides sensible defaults and a plugin ecosystem. The setup includes:

- **Base Framework**: LazyVim with lazy.nvim plugin manager
- **Theme**: Gruvbox colorscheme
- **Git Integration**: Comprehensive git workflow tools
- **Language Support**: TypeScript, Python, Lua, and more
- **Enhanced Editing**: Improved completion, snippets, and navigation

## File Structure

```
neovim/
├── default.nix           # Nix configuration for Neovim
├── init.lua             # Neovim initialization
├── README.md            # This file
└── lua/
    ├── config/
    │   └── lazy.lua     # Lazy.nvim configuration
    └── plugins/
        └── custom.lua   # Custom plugin configurations
```

## Key Features

### Git Integration

The configuration includes powerful git integration through multiple plugins:

#### LazyGit Integration
- **Plugin**: `kdheepak/lazygit.nvim`
- **Keybindings**:
  - `<leader>gg` - Open LazyGit in floating window
  - `<leader>gf` - LazyGit for current file
  - `<leader>gl` - LazyGit log view
- **Features**:
  - Floating window with custom border characters
  - Integration with neovim-remote for seamless editing
  - Custom scaling and transparency settings

#### Enhanced Git Signs
- **Plugin**: `lewis6991/gitsigns.nvim`
- **Features**:
  - Visual indicators for git changes in the gutter
  - Hunk navigation and manipulation
- **Keybindings**:
  - `]h` / `[h` - Navigate to next/previous hunk
  - `]H` / `[H` - Jump to last/first hunk
  - `<leader>ghs` - Stage hunk
  - `<leader>ghr` - Reset hunk
  - `<leader>ghS` - Stage entire buffer
  - `<leader>ghu` - Undo stage hunk
  - `<leader>ghR` - Reset entire buffer
  - `<leader>ghp` - Preview hunk inline
  - `<leader>ghb` - Show blame for current line
  - `<leader>ghd` - Diff current file
  - `<leader>ghD` - Diff against HEAD~

#### Git Blame
- **Plugin**: `f-person/git-blame.nvim`
- **Keybinding**: `<leader>gb` - Toggle git blame display
- **Features**:
  - Inline blame information
  - Disabled by default, toggle when needed

### Language Support

#### TypeScript/JavaScript
- **LSP**: TypeScript server with typescript.nvim
- **Features**:
  - Organize imports: `<leader>co`
  - Rename file: `<leader>cR`
  - Full IntelliSense support

#### Python
- **LSP**: Pyright
- **Tools**:
  - Flake8 for linting
  - Auto-formatting support

#### Lua
- **LSP**: Lua language server
- **Formatting**: Stylua

### Editor Enhancements

#### Completion and Snippets
- **Plugin**: `nvim-cmp` with multiple sources
- **Features**:
  - Emoji completion
  - Supertab navigation with `<Tab>` and `<Shift-Tab>`
  - LuaSnip integration for snippets

#### File Navigation
- **Plugin**: Enhanced Telescope
- **Features**:
  - Horizontal layout with top prompt
  - Plugin file browser: `<leader>fp`
  - Improved sorting and layout

#### Treesitter
- **Parsers**: Comprehensive language support including:
  - bash, javascript, json, lua, markdown
  - python, rust, tsx, typescript, vim, yaml

### UI Customizations

#### Colorscheme
- **Theme**: Gruvbox with dark background
- **Plugin**: `ellisonleao/gruvbox.nvim`

#### Statusline
- **Plugin**: Lualine with custom emoji indicator
- **Features**: Custom sections and indicators

#### Startup
- **Plugin**: Mini.starter instead of Alpha
- **Features**: Clean, minimal startup screen

## Dependencies

### System Packages
The following packages are automatically installed via Nix:
- `neovim` - The editor itself
- `neovim-remote` - For lazygit integration
- `delta` - Enhanced git diffs
- `lazygit` - Terminal git UI

### Environment Variables
- `EDITOR=nvim` - Default editor
- `GIT_EDITOR=nvim` - Git commit editor

## Installation

The Neovim configuration is automatically applied when the home-manager configuration is built. The setup process:

1. **Nix Configuration**: Files are symlinked to `~/.config/nvim/`
2. **Plugin Installation**: Lazy.nvim automatically installs and manages plugins
3. **LSP Setup**: Mason automatically installs language servers

## Customization

### Adding New Plugins

Add plugins to `lua/plugins/custom.lua`:

```lua
return {
  -- Your existing plugins...

  -- New plugin example
  {
    "plugin-author/plugin-name",
    config = function()
      -- Plugin configuration
    end,
  },
}
```

### Modifying Keybindings

Keybindings can be modified in the plugin configurations within `custom.lua`. For global keybindings, add them to the appropriate plugin's `keys` table.

### Language Server Configuration

Add new language servers to the `nvim-lspconfig` configuration in `custom.lua`:

```lua
{
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- Add your language server here
      your_language_server = {},
    },
  },
},
```

## Troubleshooting

### Plugin Issues
- Run `:Lazy` to manage plugins
- Use `:Lazy sync` to update all plugins
- Check `:checkhealth` for system diagnostics

### LSP Issues
- Run `:Mason` to manage language servers
- Use `:LspInfo` to check active language servers
- Check `:checkhealth lsp` for LSP diagnostics

### Git Integration Issues
- Ensure `lazygit` and `neovim-remote` are in PATH
- Check git configuration with `:!git config --list`
- Verify EDITOR environment variable with `:!echo $EDITOR`

## References

- [LazyVim Documentation](https://lazyvim.github.io/)
- [Lazy.nvim Plugin Manager](https://github.com/folke/lazy.nvim)
- [LazyGit](https://github.com/jesseduffield/lazygit)
- [Neovim Documentation](https://neovim.io/doc/)