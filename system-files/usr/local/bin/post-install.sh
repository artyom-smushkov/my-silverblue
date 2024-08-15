#!/bin/bash

flatpak override --user ~/.themes/
flatpak override --user ~/.icons/
flatpak override --user --filesystem=xdg-config/gtk-4.0
flatpak override --user --filesystem=xdg-config/gtk-3.0

flatpak install -y com.bitwarden.desktop
flatpak install -y com.slack.Slack
flatpak install -y org.telegram.desktop
flatpak install -y com.anydesk.Anydesk
flatpak install -y org.darktable.Darktable
flatpak install -y com.rawtherapee.Rawtherapee
flatpak install -y com.logseq.Logseq
flatpak install -y org.rncbc.qpwgraph
flatpak install -y fm.reaper.Reaper
flatpak install -y org.gnome.Boxes
flatpak install -y io.github.vikdevelop.SaveDesktop


git clone https://github.com/artyom-smushkov/dotfiles.git ~/Dotfiles/
stow ~/Dotfiles

read -p "Github password: " GITHUB_PASSWORD
git clone https://artyom-smushkov:${GITHUB_PASSWORD}@github.com/artyom-smushkov/piiq-dev.git /home/templarrr/Development/piiq-dev

read -p "Bitbucket password: " BITBUCKET_PASSWORD
git clone https://artyom_smushkov:${BITBUCKET_PASSWORD}@bitbucket.org/piiqmedia/piiq-media.git
