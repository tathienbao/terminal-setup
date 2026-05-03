# terminal-setup

A setup script for a beautiful terminal on Linux (Ubuntu/Debian).

## What gets installed

| Tool | Description |
|------|-------------|
| [JetBrainsMono Nerd Font](https://www.nerdfonts.com/) | Font with icons required for symbols to render correctly |
| [Starship](https://starship.rs/) | Fast, colorful prompt with Gruvbox Rainbow preset |
| [lsd](https://github.com/lsd-rs/lsd) | `ls` replacement with icons and colors |
| [bat](https://github.com/sharkdp/bat) | `cat` replacement with syntax highlighting (Dracula theme) |
| [Neovim](https://neovim.io/) | Modern vim with plugins: Dracula theme, Treesitter, lualine, nvim-tree |

### Bat themes included

Catppuccin (Latte, Frappé, Macchiato, Mocha), Rose Pine (+ Dawn, Moon), Tokyo Night (+ Storm, Moon, Day), Dracula (built-in).

### Neovim plugins

| Plugin | Description |
|--------|-------------|
| [dracula.nvim](https://github.com/Mofiqul/dracula.nvim) | Dracula colorscheme |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Better syntax highlighting for C, Lua, Bash, Python, JS |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status bar |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File tree — toggle with `Ctrl+N` |

## Install

```bash
git clone https://github.com/tathienbao/terminal-setup.git
cd terminal-setup
chmod +x install.sh
./install.sh
```

> If a Neovim config already exists at `~/.config/nvim/init.lua`, it will be backed up to `init.lua.bak` before being replaced.

## After installation

1. Set your terminal font to **JetBrainsMono Nerd Font Regular**
2. Open a new terminal to activate Starship, aliases, and colors
3. Open `nvim` once — plugins will install automatically via lazy.nvim
