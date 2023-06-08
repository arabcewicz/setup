param ($distro)
if ($distro -eq $null) {
$distro = read-host -Prompt "Enter a distribution name"
}

Write-Host "Installing and initializing wsl2 distribution $distro"
#wsl --install -d $distro --no-launch
Write-Host "--- init1.sh ---"
wsl -d $distro --cd ~ cp /mnt/c/Users/adamr/setup/install/wsl2/init1.sh ~
wsl -d $distro --cd ~ sed -i -e 's/\r$//' init1.sh
wsl -d $distro --cd ~ init1.sh

Write-Host "--- init2.sh ---"
wsl -d $distro --cd ~ -e setup/install/wsl2/init2.sh

Write-Host "--- init3.sh ---"
wsl -d $distro --cd ~ -e setup/install/wsl2/init3.sh
