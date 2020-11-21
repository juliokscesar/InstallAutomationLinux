#!/bin/bash

echo "------------------------------------------------------------"
echo "BEGINNING POST-FORMAT SOFTWARE AND DEPENDENCIES INSTALLATION"
echo "------------------------------------------------------------"

# Checks if running as sudo (root user)
if [[ "$EUID" -ne 0 ]]; then
	echo "Run this script as root"
	exit
fi

# Get current kernel version
CURRENT_LINUX_KERNEL=$(uname -r)
echo "$(CURRENT_LINUX_KERNEL)"

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
	makepkg -si
	sudo systemctl enable --now snapd.socket
	sudo ln -s /var/lib/snapd/snap /snap
}

stableProgramsToInstall=(
	base-devel
	nvidia-lts
	vlc
	p7zip
	vim
	jdk-openjdk
	jre-openjdk
	python
	gcc
	make
	cmake
	ffmpeg
	sqlite
	git
	discord
	dotnet-sdk
	dotnet-runtime
	qbittorrent
	libreoffice-still
	libreoffice-still-pt-br
	gimp
	sfml
)

aurProgramsToInstall=(
	visual-studio-code-bin
	microsoft-edge-dev-bin
)

aurProgramsToInstallGit=(
	https://aur.archlinux.org/visual-studio-code-bin.git
	https://aur.archlinux.org/microsoft-edge-dev-bin.git
)

snapProgramsToInstall=(
	spotify
)

for program in "${stableProgramsToInstall[@]}"; do
	printf "\n-------------------------------------\n"
	printf "Beginning installation of %s\n" "$program"
	printf "---------------------------------------\n"
	sudo pacman -S $program --noconfirm
done

for ((i = 0 ; i < 2 ; i++)); do
	printf "\n-------------------------------------\n"
	printf "Beginnig AUR insatllation of %s\n" "${aurProgramsToInstall[i]}"
	printf "\n-------------------------------------\n"
	git clone ${aurProgramsToInstallGit[i]}
	cd ${aurProgramsToInstall[i]}
	makepkg -sic
	cd ~/Downloads
done

installSnap
for snapProgram in "${snapProgramsToInstall[@]}"; do
	printf "\n-------------------------------------\n"
	printf "Beginning Snap Installation of %s\n" "$snapProgram"
	printf "\n-------------------------------------\n"
	sudo snap install $program
done

echo "----------------------------"
echo "INSTALLATION SCRIPT FINISHED"
echo "----------------------------"
