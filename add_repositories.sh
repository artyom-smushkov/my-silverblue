#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

curl -O https://download.docker.com/linux/fedora/docker-ce.repo
curl -O https://copr.fedorainfracloud.org/coprs/alebastr/sway-extras/repo/fedora-42/alebastr-sway-extras-fedora-42.repo
curl -O https://copr.fedorainfracloud.org/coprs/erikreider/SwayNotificationCenter/repo/fedora-42/erikreider-SwayNotificationCenter-fedora-42.repo
curl -O https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/repo/fedora-42/solopasha-hyprland-fedora-42.repo
# curl -O https://copr.fedorainfracloud.org/coprs/bieszczaders/kernel-cachyos/repo/fedora-42/bieszczaders-kernel-cachyos-fedora-42.repo
curl -O https://copr.fedorainfracloud.org/coprs/yalter/niri/repo/fedora-42/yalter-niri-fedora-42.repo
curl -O https://copr.fedorainfracloud.org/coprs/kwizart/kernel-longterm-6.12/repo/fedora-42/kwizart-kernel-longterm-6.12-fedora-42.repo

install -o 0 -g 0 -m644 docker-ce.repo /etc/yum.repos.d/docker-ce.repo
install -o 0 -g 0 -m644 alebastr-sway-extras-fedora-42.repo /etc/yum.repos.d/alebastr-sway-extras-fedora-42.repo
install -o 0 -g 0 -m644 erikreider-SwayNotificationCenter-fedora-42.repo /etc/yum.repos.d/erikreider-SwayNotificationCenter-fedora-42.repo
install -o 0 -g 0 -m644 solopasha-hyprland-fedora-42.repo /etc/yum.repos.d/solopasha-hyprland-fedora-42.repo
# install -o 0 -g 0 -m644 bieszczaders-kernel-cachyos-fedora-42.repo /etc/yum.repos.d/bieszczaders-kernel-cachyos-fedora-42.repo
install -o 0 -g 0 -m644 yalter-niri-fedora-42.repo /etc/yum.repos.d/yalter-niri-fedora-42.repo
install -o 0 -g 0 -m644 kwizart-kernel-longterm-6.12-fedora-42.repo /etc/yum.repos.d/kwizart-kernel-longterm-6.12-fedora-42.repo
