#!/bin/bash

#--- Setting infra for ssh to be able to access keys from host ---
echo "[SETUP1] Installing socat..."
sudo apt install socat -y
echo "[SETUP1] Getting wsl-ssh-agent-relay (into ~/bin) and updating script..."
wget -P ~/bin/ https://raw.githubusercontent.com/rupor-github/wsl-ssh-agent/master/docs/wsl-ssh-agent-relay
chmod +x ~/bin/wsl-ssh-agent-relay
sed -i "/RELAY_BIN=/c\RELAY_BIN=\$\{WINHOME\}/scoop/shims/npiperelay.exe" ~/bin/wsl-ssh-agent-relay
mkdir .ssh -p


echo "[SETUP1] Updating .bashrc..."
WINHOME=$(cmd.exe /c echo %USERPROFILE% 2>/dev/null | sed 's+C:\\+/mnt/c/+' | sed 's+\\+/+g' | sed 's/\r//' )
cat << EOF >>~/.bashrc

# ------ [SETUP1] -----------
~/bin/wsl-ssh-agent-relay start

export SSH_AUTH_SOCK=${HOME}/.ssh/wsl-ssh-agent.sock
export WINHOME="${WINHOME}"
export PATH=~/bin:${PATH}

alias wslssh="~bin/wsl-ssh-agent-relay start"
alias chezmoi="chezmoi -c ~/setup/chezmoi/chezmoi.toml"
# ------ [SETUP1] -----------
EOF

echo "[SETUP1] Creating link-script ~/bin/win32yank.exe ..."
cat << EOF >> ~/bin/win32yank.exe
#!/bin/sh
\$WINHOME/scoop/apps/neovim/current/bin/win32yank.exe "\$@" 2>/dev/null
EOF
chmod +x ~/bin/win32yank.exe

# reload shell now

