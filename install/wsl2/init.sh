#!/bin/bash

sudo apt install socat -y
wget -P ~/bin/ https://raw.githubusercontent.com/rupor-github/wsl-ssh-agent/master/docs/wsl-ssh-agent-relay
chmod +x ~/bin/wsl-ssh-agent-relay
sed -i "/RELAY_BIN=/c\RELAY_BIN=\$\{WINHOME\}/scoop/shims/npiperelay.exe" ~/bin/wsl-ssh-agent-relay

