param(
  [switch]$Elevated,
  [string]$Action
)

#Write-Host $Elevated
#Write-Host $Action

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-NoProfile -File "{0}" -Elevated -Action "{1}"' -f $myinvocation.MyCommand.Definition, $Action)
    }
    exit
}

#'running with full privileges'


switch ($Action) {
  "start" { 
#    Write-Host "Starting VcXsrv"
#    Start-Process "C:\Program Files\VcXsrv\xlaunch.exe" -ArgumentList ('-run C:\Users\adamr\bin\config.xlaunch')
    Write-Host "Starting Ubuntu-20.04"
    wsl -d Ubuntu-20.04 -e /home/adrab/bin/wsl-init.s
    Write-Host "Setting 192.168.99.100"
    netsh interface ip add address "vEthernet (WSL)" 192.168.99.100 255.255.255.0
    Write-Host "Starting Docker Desktop"
    Start-Process "C:\Program Files\Docker\Docker\frontend\Docker Desktop.exe"
  }

  "stop" {
    Write-Host "Stopping Docker Desktop"
    $isRunning = Get-Process "Docker Desktop" -ErrorAction SilentlyContinue
    if ($isRunning) {
      $isRunning.CloseMainWindow()
      $isRunning | Stop-Process -Force
    }
    Write-Host "Removing 192.168.99.100"
    netsh interface ip delete address "vEthernet (WSL)" 192.168.99.100
    Write-Host "Stopping Ubuntu-20.04" 
    wsl -t Ubuntu-20.04
#    Write-Host "Stopping VcXsrv"
#    $isRunning = Get-Process "vcxsrv" -ErrorAction SilentlyContinue
#    if ($isRunning) {
#      $isRunning | Stop-Process -Force
#    }
  }

  default { Write-Host "other" }
}  



# wsl -d Ubuntu-20.04 -e /home/adrab/bin/init.s
#echo Setting 192.168.99.100
#netsh interface ip add address "vEthernet (WSL)" 192.168.99.100 255.255.255.0
#"C:\Program Files\Docker\Docker\frontend\Docker Desktop.exe"


#REM netsh interface ip delete address "vEthernet (WSL)" 192.168.99.100
#REM wsl -t Ubuntu-20.04