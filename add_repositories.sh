#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

curl -O https://download.docker.com/linux/fedora/docker-ce.repo
curl -O https://repository.mullvad.net/rpm/stable/mullvad.repo
curl -O https://copr.fedorainfracloud.org/coprs/alebastr/sway-extras/repo/fedora-41/alebastr-sway-extras-fedora-41.repo
curl -O https://copr.fedorainfracloud.org/coprs/erikreider/SwayNotificationCenter/repo/fedora-41/erikreider-SwayNotificationCenter-fedora-41.repo
curl -O https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/repo/fedora-41/solopasha-hyprland-fedora-41.repo
curl -O https://copr.fedorainfracloud.org/coprs/bhavin192/emacs-pretest/repo/fedora-41/bhavin192-emacs-pretest-fedora-41.repo
install -o 0 -g 0 -m644 docker-ce.repo /etc/yum.repos.d/docker-ce.repo
install -o 0 -g 0 -m644 mullvad.repo /etc/yum.repos.d/mullvad.repo
install -o 0 -g 0 -m644 alebastr-sway-extras-fedora-41.repo /etc/yum.repos.d/alebastr-sway-extras-fedora-41.repo
install -o 0 -g 0 -m644 erikreider-SwayNotificationCenter-fedora-41.repo /etc/yum.repos.d/erikreider-SwayNotificationCenter-fedora-41.repo
install -o 0 -g 0 -m644 solopasha-hyprland-fedora-41.repo /etc/yum.repos.d/solopasha-hyprland-fedora-41.repo
install -o 0 -g 0 -m644 bhavin192-emacs-pretest-fedora-41.repo /etc/yum.repos.d/bhavin192-emacs-pretest-fedora-41.repo
