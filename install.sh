#!/usr/bin/env bash
set -e

echo "==> [1/4] Installing JetBrainsMono Nerd Font..."
mkdir -p ~/.local/share/fonts
curl -fLo ~/.local/share/fonts/JetBrainsMono.zip \
  "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip"
unzip -o ~/.local/share/fonts/JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMonoNF
rm ~/.local/share/fonts/JetBrainsMono.zip
fc-cache -fv
echo "    Done. Set font to 'JetBrainsMono Nerd Font Regular' in your terminal emulator."

echo "==> [2/4] Installing Starship prompt..."
mkdir -p ~/.local/bin
curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir ~/.local/bin

echo "==> [3/4] Installing lsd and bat..."
sudo apt install -y lsd bat

echo "==> [4/4] Configuring ~/.bashrc..."
BASHRC="$HOME/.bashrc"

if ! grep -q "starship init bash" "$BASHRC"; then
  cat >> "$BASHRC" << 'EOF'

# Terminal ricing
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
echo "Remember to set your terminal font to: JetBrainsMono Nerd Font Regular"
