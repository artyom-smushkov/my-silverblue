#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

curl -O https://download.docker.com/linux/fedora/docker-ce.repo
curl -O https://repository.mullvad.net/rpm/stable/mullvad.repo
curl -O https://copr.fedorainfracloud.org/coprs/alebastr/sway-extras/repo/fedora-41/alebastr-sway-extras-fedora-41.repo
curl -O https://copr.fedorainfracloud.org/coprs/erikreider/SwayNotificationCenter/repo/fedora-41/erikreider-SwayNotificationCenter-fedora-41.repo
install -o 0 -g 0 -m644 docker-ce.repo /etc/yum.repos.d/docker-ce.repo
install -o 0 -g 0 -m644 mullvad.repo /etc/yum.repos.d/mullvad.repo
install -o 0 -g 0 -m644 alebastr-sway-extras-fedora-41.repo /etc/yum.repos.d/alebastr-sway-extras-fedora-41.repo
install -o 0 -g 0 -m644 erikreider-SwayNotificationCenter-fedora-41.repo /etc/yum.repos.d/erikreider-SwayNotificationCenter-fedora-41.repo
dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

### Install packages

dnf install foot stow podman-compose syncthing rofi-wayland swww qtile qtile-wayland qtile-extras xdg-desktop-portal-wlr swappy waybar emacs fish
dnf install hyprland hypridle hyprcursor hyprlock xdg-desktop-portal-hyprland SwayNotificationCenter
dnf install gnome-keyring
dnf install mullvad-vpn
# dnf override remove solaar

#### Example for enabling a System Unit File

systemctl enable podman.socket
systemctl enable docker.service
systemctl enable brew-setup.service

# Make these so script will work
mkdir -p /var/home
mkdir -p /var/roothome

# Brew Install Script
curl --retry 3 -Lo /tmp/brew-install https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
chmod +x /tmp/brew-install
/tmp/brew-install
tar --zstd -cvf /usr/share/homebrew.tar.zst /home/linuxbrew/.linuxbrew
