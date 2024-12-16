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
rpm-ostree install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

### Install packages

rpm-ostree install foot stow podman-compose syncthing emacs rofi-wayland swww qtile qtile-wayland qtile-extras xdg-desktop-portal-wlr swappy waybar python3-lsp-server+all
rpm-ostree install hyprland hypridle hyprcursor hyprlock xdg-desktop-portal-hyprland SwayNotificationCenter
# rpm-ostree override remove solaar

#### Example for enabling a System Unit File

systemctl enable podman.socket
systemctl enable docker.service
