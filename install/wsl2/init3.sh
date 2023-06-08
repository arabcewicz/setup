#/bin/bash

echo "[SETUP3] Activating home manager..."
nix run home-manager/master -- init --switch

echo "[SETUP3] Executing 'home-manager switch'..."
home-manager switch

echo "[SETUP3] Removing chezmoi (now it's installed through home-manager)..."
rm ~/bin/chezmoi
