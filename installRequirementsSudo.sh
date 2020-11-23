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

stableProgramsToInstall=(
	base-devel
	cpio
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

# Installing stable programs from main arch linux repo (pacman)
for program in "${stableProgramsToInstall[@]}"; do
	printf "\n-------------------------------------\n"
	printf "Beginning installation of %s\n" "$program"
	printf "---------------------------------------\n"
	sudo pacman -S $program --noconfirm
done

echo "-----------------------------------"
echo "STABLE INSTALLATION SCRIPT FINISHED"
echo "-----------------------------------"
