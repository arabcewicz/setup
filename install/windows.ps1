# It would be nice to use Win+L as Right, but it seems imposible to remap the Lock functionality... This doesn't work
# Set-ItemProperty -Path "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoWinKeys" -Type DWORD -Value 1
#

# Some env used by various command line apps
[System.Environment]::SetEnvironmentVariable('HOME2',$Env:USERPROFILE,[System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable('XDG_CONFIG_HOME2', $Env:USERPROFILE +'\.config',[System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable('VIFM2', $env:USERPROFILE +'\.config\vifm',[System.EnvironmentVariableTarget]::User)


scoop install neovim
scoop install vcredist2022 # suggested by neovim
scoop install vifm
