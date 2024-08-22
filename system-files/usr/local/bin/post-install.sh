#!/bin/bash

flatpak override --user --filesystem=~/.themes/
flatpak override --user --filesystem=~/.icons/
flatpak override --user --filesystem=xdg-config/gtk-4.0
flatpak override --user --filesystem=xdg-config/gtk-3.0

daily_install.sh

until read -s -p "Github password: " GITHUB_PASSWORD && git clone https://artyom-smushkov:${GITHUB_PASSWORD}@github.com/artyom-smushkov/dotfiles.git ~/Dotfiles/
do
    echo "Git clone failed, likely invalid password, try again"
done
cd ~/Dotfiles
stow --adopt .
git restore .

cd ~/Distroboxes
distrobox assemble create --file opensuse.ini
distrobox assemble create --file ubuntu.ini
distrobox assemble create --file bazzite.ini

cd ~

git clone https://artyom-smushkov:${GITHUB_PASSWORD}@github.com/artyom-smushkov/piiq-dev.git /home/templarrr/Development/piiq-dev-containers

until read -s -p "Bitbucket password: " BITBUCKET_PASSWORD && git clone https://artyom_smushkov:${BITBUCKET_PASSWORD}@bitbucket.org/piiqmedia/piiq-media.git /home/templarrr/Development/piiq-src
do
    echo "Git clone failed, likely invalid password, try again"
done
