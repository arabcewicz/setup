Set-Alias -Name vim -Value nvim
Set-Alias -Name che -Value "chezmoi edit"
Set-Alias -Name chep -Value "chezmoi edit ~/.config/powershell/profile.ps1"

Invoke-Expression (&starship init powershell)
winfetch
