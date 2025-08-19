#!/bin/bash

set -ouex pipefail

systemctl enable podman.socket
systemctl enable docker.service
