#!/bin/bash

echo "-----------------------------------------------"
echo "BEGINNING POST-FOMART AUR SOFTWARE INSTALLATION"
echo "-----------------------------------------------"

# Checks if running as sudo (AUR doesn't build as sudo user)
if [[ "$EUID" -eq 0 ]]; then
	echo "AUR not allowed to run as super user"
	exit
fi

# Get current kernel version
CURRENT_LINUX_KERNEL=$(uname -r)
echo "$CURRENT_LINUX_KERNEL"

# Only runs if the kernel version is 5.4 LTS
if [[ $CURRENT_LINUX_KERNEL != 5.4* ]]; then
        echo "INSTALL LINUX 5.4 LTS KERNEL BEFORE RUNNING THIS SCRIPT"
        exit
fi

sudo pacman -Syyu

cd ~/Downloads

function installSnap() {
        echo "INSTALLING SNAP"
        git clone https://aur.archlinux.org/snapd.git
        cd snapd
        makepkg -sic
        sudo systemctl enable --now snapd.socket
        sudo ln -s /var/lib/snapd/snap /snap
        cd ~/Downloads
}

aurProgramsToInstall=(
	visual-studio-code-bin
	micorosft-edge-dev-bin
	sublime-text-3
)

aurProgramsToInstallGit=(
	https://aur.archlinux.org/visual-studio-code-bin.git
        https://aur.archlinux.org/microsoft-edge-dev-bin.git
        https://aur.archlinux.org/sublime-text-3.git
)

snapProgramsToInstall=(
	spotify
)

## Installing AUR programs
for ((i = 0 ; i < 2 ; i++)); do
        printf "\n-------------------------------------\n"
        printf "Beginnig AUR insatllation of %s\n" "${aurProgramsToInstall[i]}"
        printf "\n-------------------------------------\n"
        git clone ${aurProgramsToInstallGit[i]}
        cd ${aurProgramsToInstall[i]}
        makepkg -sic
        cd ~/Downloads
done

## Installing snap programs
installSnap
for snapProgram in "${snapProgramsToInstall[@]}"; do
        printf "\n-------------------------------------\n"
        printf "Beginning Snap Installation of %s\n" "$snapProgram"
        printf "\n-------------------------------------\n"
        sudo snap install $snapProgram
done

echo "----------------------------------"
echo "AUR AND SNAP INSTALLATION FINISHED"
echo "----------------------------------"
