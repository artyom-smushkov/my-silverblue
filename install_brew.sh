#!/bin/bash

set -ouex pipefail

# Make these so brew script will work
mkdir -p /var/home
mkdir -p /var/roothome

curl --retry 3 -Lo /tmp/brew-install https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
chmod +x /tmp/brew-install
/tmp/brew-install
tar --zstd -cvf /usr/share/homebrew.tar.zst /home/linuxbrew/.linuxbrew
