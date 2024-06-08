#!/bin/bash

echo "[SETUP2] Clonning 'setup' repo..."
git clone git@github.com:arabcewicz/setup.git

echo "[SETUP2] Installing 'chezmoi'... in ~/bin"
sh -c "$(wget -qO- get.chezmoi.io)"

echo "[SETUP2] Executing 'chezmoi apply'"
mkdir -p ~/.config
~/bin/chezmoi -c ~/setup/chezmoi/chezmoi.toml apply
# ~/bin/chezmoi -c ~/setup/chezmoi/chezmoi.toml apply ~/.config/nix
# ~/bin/chezmoi -c ~/setup/chezmoi/chezmoi.toml apply ~/.config/home-manager
#
#
# echo "[SETUP2] Installing nix package manager..."
# sh <(curl -L https://nixos.org/nix/install) --no-daemon

echo "[SETUP2] Removing ~/bin/chezmoi (is installed through snapd now)..."
rm ~/bin/chezmoi
#
echo "[SETUP2] Executing 'chezmoi apply' again to see with snapd installd binanry"
chezmoi apply

echo "[SETUP2] Switching to zsh..."
mkdir -p ~/.cache/zsh
which zsh | sudo tee -a /etc/shells
chsh -s $(which zsh)
