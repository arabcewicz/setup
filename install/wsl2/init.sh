#!/bin/bash

WINHOME=`cmd.exe /c echo %USERPROFILE% 2>/dev/null`

# ssh can use keys from host agent
echo "Setting infra for ssh to be able to access keys from host..."
sudo apt install socat -y
wget -P ~/bin/ https://raw.githubusercontent.com/rupor-github/wsl-ssh-agent/master/docs/wsl-ssh-agent-relay
chmod +x ~/bin/wsl-ssh-agent-relay
sed -i "/RELAY_BIN=/c\RELAY_BIN=\$\{WINHOME\}/scoop/shims/npiperelay.exe" ~/bin/wsl-ssh-agent-relay

cat <<'EOF' >>~/.bashrc

# ------ init.sh -----------
export WINHOME="$WINHOME"
~/bin/wsl-ssh-agent-relay start
mkdir .ssh -p
export SSH_AUTH_SOCK=${HOME}/.ssh/wsl-ssh-agent.sock
# ------ init.sh -----------
EOF

. .bashrc

echo "Clonning setup repo..."
git clone git@github.com:arabcewicz/setup.git

echo "Installing chezmoi..."
sh -c "$(wget -qO- get.chezmoi.io)"

~/bin/chezmoi -c ~/setup/chezmoi/chezmoi.toml

