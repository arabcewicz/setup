# It would be nice to use Win+L as Right, but it seems imposible to remap the Lock functionality... This doesn't work
# Set-ItemProperty -Path "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoWinKeys" -Type DWORD -Value 1
#
# 1. go to HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System, if there is no System, create one
#2. create a 32bit DWORD, name it DisableLockWorkstation
#3. set the value of DisableLockWorkstation to 1
#
# to disable WIN+W:
# create key HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace and value AllowWindowsInkWorkspace (DWORD32), set to 0
#
#


# Install scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

scoop add bucket extras
#scoop add bucket java

scoop install npiperelay
scoop install git
scoop install chezmoi
scoop install vcredist2022
scoop install neovim
scoop install ripgrep
scoop install fd
scoop install eza
scoop install bat
scoop install zoxide
scoop install fzf
scoop install winfetch
scoop install gdu
scoop install btop
scoop install gcc
scoop install sudo
scoop install pwsh
scoop install powership
scoop install biodiff
scoop install openssh

scoop install wezterm
scoop install vcxsrv
scoop install 7zip
scoop install autohotkey
scoop install coretemp
scoop install keepassxc
scoop install resilio-sync-np
scoop install powertoys
scoop install sumatrapdf
scoop install sysinternals
scoop install quicklook


scoop install mvn
scoop install coursier
scoop install rustup
scoop install sqlite




# Some env used by various command line apps
[System.Environment]::SetEnvironmentVariable('HOME',$Env:USERPROFILE,[System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable('XDG_CONFIG_HOME', $Env:USERPROFILE +'\.config',[System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable('VIFM', $Env:USERPROFILE +'\.config\vifm',[System.EnvironmentVariableTarget]::User)
#[System.Environment]::SetEnvironmentVariable('KOMOREBI_CONFIG_HOME', $Env:USERPROFILE +'\.config\komorebi',[System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable('GIT_SSH_COMMAND', "'" + $Env:USERPROFILE +"\scoop\shims\ssh.exe' -T",[System.EnvironmentVariableTarget]::User)
 # $env:GIT_SSH_COMMAND = "'$env:HOME\scoop\shims\ssh.exe' -T"
[System.Environment]::SetEnvironmentVariable('OS_ICON','',[System.EnvironmentVariableTarget]::User)
#[System.Environment]::SetEnvironmentVariable('COMSPEC','powershell.exe',[System.EnvironmentVariableTarget]::User)


#cd ~\scoop\apps\idea-ultimate\current\IDE\bin
# ideavim
#idea.exe installPlugins IdeaVIM
#idea.exe installPlugins com.joshestein.ideavim-quickscope
##idea.exe installPlugins AceJump
##idea.exe installPlugins org.jetbrains.IdeaVim-EasyMotion
##idea.exe installPlugins com.github.dankinsoid.multicursor
## other
#idea.exe installPlugins com.github.copilot
#idea.exe installPlugins org.intellij.scala
#idea.exe installPlugins socrates.tabshifter
#idea.exe installPlugins com.intellij.plugins.xwinkeymap
#idea.exe installPlugins io.github.xiaopihai7256

# installing idea plugins on WSL2 host (remote development):
# cd ~/.cache/JetBrains/RemoteDev/dist
# cd %instance%
# bin/remote-dev-server.sh installPlugins PROJECT_PATH pluginId


New-Item $env:USERPROFILE\Documents\PowerShell\Profile.ps1 -Force
Set-Content $env:USERPROFILE\Documents\PowerShell\Profile.ps1 ". ~\.config\powershell\profile.ps1"
# change ComSpec env var into "pwsh.exe"

sudo New-Item -ItemType SymbolicLink -Path ~/.config/chezmoi -Target ~/setup/chezmoi

#sudo New-Item -ItemType SymbolicLink -Target "~\setup\jetbrains\keymaps" -Path "~\scoop\apps\idea-ultimate\current\profile\config\keymaps"
#sudo New-Item -ItemType SymbolicLink -Target "~\setup\jetbrains\templates" -Path "~\scoop\apps\idea-ultimate\current\profile\config\templates"

sudo New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run -Name xlaunch -Value "$Env:USERPROFILE\scoop\shims\xlaunch.exe -run $Env:USERPROFILE\.config\vcxsrv\config.xlaunch"
#sudo New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run -Name komorebic -Value "$Env:USERPROFILE\scoop\shims\komorebic.exe start --await-configuration"


# after installing Brave through scoop, it uses scoop's local User-Dir (see shortcut properties) via parameter. You want to add it to windows' "open by" default app:
# 0. Set Brave as default browser
# 1. Check the `ProgId` for Brave (sth like `BraveHTML.NUKOK6QA4CGDOQLA5IFTMTZCMQ`) in HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice
# 2. Search registry for this ProgId; it should be somewhere under `Computer\HKEY_USERS\S-1-5-21-3755535739-746031237-2308601346-1001\SOFTWARE\Classes\BraveHTML.NUKOK6QA4CGDOQLA5IFTMTZCMQ`
# 3. Go deeper to shell -> open -> command and add argument "-user-data-dir="<dir-to-scoop>\apps\brave\current\User Data"
