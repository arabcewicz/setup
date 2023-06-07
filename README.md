

## Windows

* add `XDG_CONFIG_HOME=C:\Users\adamr\.config\` env to force the config placement for neovim (default is in AppData/Local/neovim)


## WSL2
0. Start (on Windows) KeePassXC with ssh key to github
1. Prepare wsl-ssh communication
```
wsl --install <distro>
cp /mnt/c/Users/<user>/setup/install/wsl2/init* .
./init1.sh
```

2. Relaunch distro
3. Get and put in place dotfiles
```
./init2.sh
```