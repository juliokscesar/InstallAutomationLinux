#!/bin/bash

echo "-----------------------------------------------"
echo "BEGINNING POST-FOMART AUR SOFTWARE INSTALLATION"
echo "-----------------------------------------------"

# Checks if running as sudo (AUR doesn't build as sudo user)
if [[ "$EUID" -eq 0 ]]; then
	echo "AUR not allowed to run as super user"
	exit
fi

sudo pacman -Syyu

cd ~/Downloads

aurProgramsToInstall=(
	visual-studio-code-bin
	microsoft-edge-dev-bin
	bitwarden-bin
)

aurProgramsToInstallGit=(
	https://aur.archlinux.org/visual-studio-code-bin.git
        https://aur.archlinux.org/microsoft-edge-dev-bin.git
        https://aur.archlinux.org/bitwarden-bin.git
)

## Installing AUR programs
for ((i = 0 ; i < 3 ; i++)); do
        printf "\n-------------------------------------\n"
        printf "Beginnig AUR insatllation of %s\n" "${aurProgramsToInstall[i]}"
        printf "\n-------------------------------------\n"
        git clone ${aurProgramsToInstallGit[i]}
        cd ${aurProgramsToInstall[i]}
        makepkg -sic
        cd ~/Downloads
done

echo "----------------------------------"
echo "AUR AND INSTALLATION FINISHED"
echo "----------------------------------"
