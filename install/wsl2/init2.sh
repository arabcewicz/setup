#!/bin/bash

echo "Clonning setup repo..."
git clone git@github.com:arabcewicz/setup.git

echo "Installing chezmoi..."
sh -c "$(wget -qO- get.chezmoi.io)"

~/bin/chezmoi -c ~/setup/chezmoi/chezmoi.toml apply

