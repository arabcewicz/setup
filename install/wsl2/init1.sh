#!/bin/sh
echo "[SETUP1] Updating system..."
sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y

echo "[SETUP1] Setting infra for ssh to be able to access keys from host"
echo "[SETUP1]   Installing socat..."
sudo apt install socat -y
echo "[SETUP1]   Getting wsl-ssh-agent-relay (into ~/bin) and updating script..."
wget -P ~/bin/ https://raw.githubusercontent.com/rupor-github/wsl-ssh-agent/master/docs/wsl-ssh-agent-relay
chmod +x ~/bin/wsl-ssh-agent-relay
sed -i "/RELAY_BIN=/c\RELAY_BIN=\$\{WINHOME\}/scoop/shims/npiperelay.exe" ~/bin/wsl-ssh-agent-relay
mkdir .ssh -p


echo "[SETUP1] Generating .setuprc and updating .bashrc..."
WINHOME=$(cmd.exe /c echo %USERPROFILE% 2>/dev/null | sed 's+C:\\+/mnt/c/+' | sed 's+\\+/+g' | sed 's/\r//' )
cat << EOF >~/.setuprc
# ------ [SETUP1] -----------
export SSH_AUTH_SOCK=\${HOME}/.ssh/wsl-ssh-agent.sock
export WINHOME=${WINHOME}
export PATH=$HOME/bin:\${PATH}
export BROWSER=brave.exe

alias wslssh="~/bin/wsl-ssh-agent-relay start"
alias chezmoi="chezmoi -c ~/setup/chezmoi/chezmoi.toml"

~/bin/wsl-ssh-agent-relay start
# ------ [SETUP1] -----------
EOF

echo "if [ -e \$HOME/.setuprc ]; then . \$HOME/.setuprc; fi" >> ~/.bashrc

# reload shell now

