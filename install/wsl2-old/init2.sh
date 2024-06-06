#!/bin/bash

echo "[SETUP2] Clonning 'setup' repo..."
git clone git@github.com:arabcewicz/setup.git

echo "[SETUP2] Installing 'chezmoi'..."
sh -c "$(wget -qO- get.chezmoi.io)"

echo "[SETUP2] Executing 'chezmoi apply for .config/nix and .config/home-manager'..."
mkdir -p ~/.config
~/bin/chezmoi -c ~/setup/chezmoi/chezmoi.toml apply ~/.config/nix
~/bin/chezmoi -c ~/setup/chezmoi/chezmoi.toml apply ~/.config/home-manager


echo "[SETUP2] Installing nix package manager..."
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# relaunch distro now
