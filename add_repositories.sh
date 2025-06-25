#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

curl -O https://download.docker.com/linux/fedora/docker-ce.repo
curl -O https://copr.fedorainfracloud.org/coprs/alebastr/sway-extras/repo/fedora-42/alebastr-sway-extras-fedora-42.repo
curl -O https://copr.fedorainfracloud.org/coprs/erikreider/SwayNotificationCenter/repo/fedora-42/erikreider-SwayNotificationCenter-fedora-42.repo

install -o 0 -g 0 -m644 docker-ce.repo /etc/yum.repos.d/docker-ce.repo
install -o 0 -g 0 -m644 alebastr-sway-extras-fedora-42.repo /etc/yum.repos.d/alebastr-sway-extras-fedora-42.repo
install -o 0 -g 0 -m644 erikreider-SwayNotificationCenter-fedora-42.repo /etc/yum.repos.d/erikreider-SwayNotificationCenter-fedora-42.repo
