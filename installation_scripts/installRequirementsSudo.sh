#!/bin/bash

echo "------------------------------------------------------------"
echo "BEGINNING POST-FORMAT SOFTWARE AND DEPENDENCIES INSTALLATION"
echo "------------------------------------------------------------"

# Checks if running as sudo (root user)
if [[ "$EUID" -ne 0 ]]; then
	echo "Run this script as root"
	exit
fi

sudo pacman -Syyu

cd ~/Downloads

stableProgramsToInstall=(
	base-devel
	cpio
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
