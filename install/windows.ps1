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
# Some env used by various command line apps
[System.Environment]::SetEnvironmentVariable('HOME2',$Env:USERPROFILE,[System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable('XDG_CONFIG_HOME2', $Env:USERPROFILE +'\.config',[System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable('VIFM2', $Env:USERPROFILE +'\.config\vifm',[System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable('KOMOREBI_CONFIG_HOME', $Env:USERPROFILE +'\.config\komorebi',[System.EnvironmentVariableTarget]::User)


scoop install 7zip
scoop install autohotkey
scoop install chezmoi
scoop install git
scoop install komorebi
scoop install neovim
scoop install poppler      # pdftotext used by vifm
scoop install sumatrapdf
scoop install vcredist2022 #suggested by neovim
scoop install vifm
scoop install wezterm
scoop install idea-ultimate


cd ~\scoop\apps\idea-ultimate\current\IDE\bin
# ideavim
idea.exe installPlugins IdeaVIM
idea.exe installPlugins com.joshestein.ideavim-quickscope
idea.exe installPlugins AceJump
idea.exe installPlugins org.jetbrains.IdeaVim-EasyMotion
idea.exe installPlugins com.github.dankinsoid.multicursor
# other
idea.exe installPlugins com.github.copilot
idea.exe installPlugins org.intellij.scala
idea.exe installPlugins socrates.tabshifter
idea.exe installPlugins com.intellij.plugins.xwinkeymap
idea.exe installPlugins io.github.xiaopihai7256



