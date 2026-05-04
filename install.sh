#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> [1/6] Installing JetBrainsMono Nerd Font..."
mkdir -p ~/.local/share/fonts
curl -fLo ~/.local/share/fonts/JetBrainsMono.zip \
  "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip"
unzip -o ~/.local/share/fonts/JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMonoNF
rm ~/.local/share/fonts/JetBrainsMono.zip
fc-cache -fv
echo "    Done. Set font to 'JetBrainsMono Nerd Font Regular' in your terminal emulator."

echo "==> [2/6] Installing Starship prompt..."
mkdir -p ~/.local/bin
curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir ~/.local/bin
mkdir -p ~/.config
cp "$SCRIPT_DIR/starship.toml" ~/.config/starship.toml
echo "    Applied Gruvbox Rainbow preset."

echo "==> [3/6] Installing lsd and bat..."
sudo apt install -y lsd bat

echo "==> [4/6] Installing bat themes..."
mkdir -p ~/.config/bat/themes

# Catppuccin (github.com/catppuccin/bat)
curl -fLo ~/.config/bat/themes/Catppuccin\ Latte.tmTheme \
  "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme"
curl -fLo ~/.config/bat/themes/Catppuccin\ Frappe.tmTheme \
  "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme"
curl -fLo ~/.config/bat/themes/Catppuccin\ Macchiato.tmTheme \
  "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme"
curl -fLo ~/.config/bat/themes/Catppuccin\ Mocha.tmTheme \
  "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme"

# Rose Pine (github.com/rose-pine/tm-theme)
curl -fLo ~/.config/bat/themes/Rose\ Pine.tmTheme \
  "https://github.com/rose-pine/tm-theme/raw/main/dist/rose-pine.tmTheme"
curl -fLo ~/.config/bat/themes/Rose\ Pine\ Dawn.tmTheme \
  "https://github.com/rose-pine/tm-theme/raw/main/dist/rose-pine-dawn.tmTheme"
curl -fLo ~/.config/bat/themes/Rose\ Pine\ Moon.tmTheme \
  "https://github.com/rose-pine/tm-theme/raw/main/dist/rose-pine-moon.tmTheme"

# Tokyo Night (github.com/folke/tokyonight.nvim)
curl -fLo ~/.config/bat/themes/Tokyo\ Night.tmTheme \
  "https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme"
curl -fLo ~/.config/bat/themes/Tokyo\ Night\ Storm.tmTheme \
  "https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_storm.tmTheme"
curl -fLo ~/.config/bat/themes/Tokyo\ Night\ Moon.tmTheme \
  "https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_moon.tmTheme"
curl -fLo ~/.config/bat/themes/Tokyo\ Night\ Day.tmTheme \
  "https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_day.tmTheme"

batcat cache --build

echo "==> [5/6] Installing Neovim and Zathura..."
sudo apt install -y neovim zathura
mkdir -p ~/.config/nvim
[ -f ~/.config/nvim/init.lua ] && cp ~/.config/nvim/init.lua ~/.config/nvim/init.lua.bak && echo "    Backed up existing config to init.lua.bak"
cp "$SCRIPT_DIR/nvim/init.lua" ~/.config/nvim/init.lua
echo "    Config copied. Plugins will install automatically on first launch."
echo "    Run :Lazy sync inside nvim if needed."

echo "==> [6/6] Configuring dircolors and ~/.bashrc..."
dircolors -p > ~/.dircolors
sed -i 's/^DIR 01;34/DIR 01;38;5;75/' ~/.dircolors

BASHRC="$HOME/.bashrc"

if ! grep -q "starship init bash" "$BASHRC"; then
  cat >> "$BASHRC" << 'EOF'

# Terminal ricing
eval "$(dircolors ~/.dircolors)"
export BAT_THEME="Dracula"
eval "$(starship init bash)"
alias ls='lsd'
alias cat='batcat'
EOF
  echo "    Added to ~/.bashrc."
else
  echo "    ~/.bashrc already configured, skipping."
fi

echo ""
echo "Done! Open a new terminal to see the changes."
echo "Reminders:"
echo "  - Set terminal font to: JetBrainsMono Nerd Font Regular"
echo "  - Open nvim once to let plugins install automatically"
echo "  - Use Ctrl+N inside nvim to toggle the file tree"
