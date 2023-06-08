#/bin/bash
echo "[SETUP3] Activating home manager..."
nix run home-manager/master -- init --switch

echo "[SETUP3] Executing 'home-manager switch'..."
home-manager switch

echo "[SETUP3] Removing chezmoi (now it's installed through home-manager)..."
rm ~/bin/chezmoi

echo "[SETUP3] Executing 'chezmoi apply'..."
chezmoi -c ~/setup/chezmoi/chezmoi.toml apply

echo "[SETUP3] Switching to zsh..."
mkdir -p ~/.cache/zsh
which zsh | sudo tee -a /etc/shells
chsh -s $(which zsh)
