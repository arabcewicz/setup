#!/bin/bash

# ssh can use keys from host agent
echo "Setting infra for ssh to be able to access keys from host..."
sudo apt install socat -y
wget -P ~/bin/ https://raw.githubusercontent.com/rupor-github/wsl-ssh-agent/master/docs/wsl-ssh-agent-relay
chmod +x ~/bin/wsl-ssh-agent-relay
sed -i "/RELAY_BIN=/c\RELAY_BIN=\$\{WINHOME\}/scoop/shims/npiperelay.exe" ~/bin/wsl-ssh-agent-relay
mkdir .ssh -p


WINHOME=$(cmd.exe /c echo %USERPROFILE% 2>/dev/null | sed 's+C:\\+/mnt/c/+' | sed 's+\\+/+g' | sed 's/\r//' )
cat << EOF >>~/.bashrc

# ------ init.sh -----------
export WINHOME="${WINHOME}"
~/bin/wsl-ssh-agent-relay start
export SSH_AUTH_SOCK=${HOME}/.ssh/wsl-ssh-agent.sock
# ------ init.sh -----------
EOF

# reload shell now

