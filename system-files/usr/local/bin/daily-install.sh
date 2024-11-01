#!/bin/bash

flatpak install -y com.bitwarden.desktop
flatpak install -y com.slack.Slack
flatpak install -y org.telegram.desktop
flatpak install -y com.anydesk.Anydesk
flatpak install -y org.darktable.Darktable
flatpak install -y com.rawtherapee.RawTherapee
flatpak install -y org.rncbc.qpwgraph
flatpak install -y fm.reaper.Reaper
flatpak install -y org.gnome.Boxes
flatpak install -y io.github.vikdevelop.SaveDesktop
flatpak install -y org.gnome.Geary
flatpak install -y me.kozec.syncthingtk
flatpak install -y org.gnome.Lollypop
flatpak install -y org.kde.kid3
flatpak install -y io.github.zen_browser.zen

brew update
brew bundle install --cleanup --file /var/home/templarrr/.config/brewfile/Brewfile --no-lock
brew upgrade
