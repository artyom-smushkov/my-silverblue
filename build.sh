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

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
rpm-ostree install foot stow podman-compose syncthing kitty fish emacs hypridle hyprlock rofi-wayland swww SwayNotificationCenter qtile qtile-wayland qtile-extras alacritty xdg-desktop-portal-wlr
rpm-ostree override remove solaar

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File

systemctl enable podman.socket
systemctl enable docker.service
