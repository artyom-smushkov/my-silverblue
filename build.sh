#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

curl -O https://download.docker.com/linux/fedora/docker-ce.repo
curl -O https://repository.mullvad.net/rpm/stable/mullvad.repo
curl -O https://copr.fedorainfracloud.org/coprs/lexa/SwayNotificationCenter/repo/fedora-40/lexa-SwayNotificationCenter-fedora-40.repo
curl -O https://copr.fedorainfracloud.org/coprs/alebastr/sway-extras/repo/fedora-40/alebastr-sway-extras-fedora-40.repo
curl -O https://copr.fedorainfracloud.org/coprs/frostyx/qtile/repo/fedora-40/frostyx-qtile-fedora-40.repo
install -o 0 -g 0 -m644 docker-ce.repo /etc/yum.repos.d/docker-ce.repo
install -o 0 -g 0 -m644 mullvad.repo /etc/yum.repos.d/mullvad.repo
install -o 0 -g 0 -m644 lexa-SwayNotificationCenter-fedora-40.repo /etc/yum.repos.d/lexa-SwayNotificationCenter-fedora-40.repo
install -o 0 -g 0 -m644 alebastr-sway-extras-fedora-40.repo /etc/yum.repos.d/alebastr-sway-extras-fedora-40.repo
install -o 0 -g 0 -m644 frostyx-qtile-fedora-40.repo /etc/yum.repos.d/frostyx-qtile-fedora-40.repo
rpm-ostree install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

### Install packages

rpm-ostree install foot stow podman-compose syncthing fish emacs rofi-wayland swww SwayNotificationCenter qtile qtile-wayland qtile-extras alacritty xdg-desktop-portal-wlr swappy dfu-util waybar river libvterm
rpm-ostree override remove solaar

#### Example for enabling a System Unit File

systemctl enable podman.socket
systemctl enable docker.service

# Homebrew
# Convince the installer we are in CI
touch /.dockerenv

# Make these so script will work
mkdir -p /var/home
mkdir -p /var/roothome

# Brew Install Script
curl -Lo /tmp/brew-install https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
chmod +x /tmp/brew-install
/tmp/brew-install
