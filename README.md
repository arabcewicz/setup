
## Windows

* add `XDG_CONFIG_HOME=C:\Users\adamr\.config\` env to force the config placement for neovim (default is in AppData/Local/neovim)


## WSL2
Assuming that `setup` repo is cloned in Windows in home directory.

0.1. Start (on Windows) KeePassXC with ssh key to github
0.2. Unregister existing distro if you want to replace it with a fresh one:
```
wsl --unregister <distro>
```
1. Install distro
```
wsl --install <distro>
```
2. Exit from linux and run
```
.\setup\install\wsl\copy-init-scripts.ps1 <distro>
```
Afer that you'll see `init1.sh`, `init2.sh` and `init3.sh` scripts in linux' home dir.

3. Launch all initX.sh scripts relauching wsl between executing them

