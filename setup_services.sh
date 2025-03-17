#!/bin/bash

set -ouex pipefail

systemctl enable podman.socket
systemctl enable docker.service
systemctl enable brew-setup.service
systemctl enable mullvad-daemon.service
systemctl enable lactd.service
