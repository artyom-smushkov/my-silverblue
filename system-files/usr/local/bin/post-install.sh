#!/bin/bash

flatpak override --user --filesystem=~/.themes/
flatpak override --user --filesystem=~/.icons/
flatpak override --user --filesystem=xdg-config/gtk-4.0
flatpak override --user --filesystem=xdg-config/gtk-3.0

daily-install.sh

until read -s -p "Github password: " GITHUB_PASSWORD && git clone https://artyom-smushkov:${GITHUB_PASSWORD}@github.com/artyom-smushkov/dotfiles.git ~/Dotfiles/
do
    echo "Git clone failed, likely invalid password, try again"
done
cd ~/Dotfiles
stow --adopt .
git restore .

cd ~

distrobox assemble create --file .config/distrobox/assemble.ini

git clone https://artyom-smushkov:${GITHUB_PASSWORD}@github.com/artyom-smushkov/piiq-dev.git /home/templarrr/Development/piiq-dev-containers
git clone https://artyom-smushkov:${GITHUB_PASSWORD}@github.com/artyom-smushkov/my-silverblue.git /home/templarrr/Development/my-silverblue

until read -s -p "Bitbucket password: " BITBUCKET_PASSWORD && git clone https://artyom_smushkov:${BITBUCKET_PASSWORD}@bitbucket.org/piiqmedia/piiq-media.git /home/templarrr/Development/piiq-src
do
    echo "Git clone failed, likely invalid password, try again"
done

systemctl --user enable syncthing.service
systemctl --user start syncthing.service

rpm-ostree install mullvad-vpn
systemctl enable mullvad-daemon.service

xdg-mime default com.vivaldi.Vivaldi.desktop x-scheme-handler/https
xdg-mime default com.vivaldi.Vivaldi.desktop x-scheme-handler/http

git config --global user.email "artyom.smushkov@gmail.com"
git config --global user.name "Artem Smushkov"
