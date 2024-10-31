#!/bin/bash

declare -a SRC_DIRS=(
  "/var/home/templarrr/Documents/"
  "/var/home/templarrr/Music/"
  "/var/home/templarrr/Pictures/"
  "/var/home/templarrr/.ssh/"
  "/var/home/templarrr/Videos/"
)

ENCRYPTION_PASSPHRASE=$(</var/home/templarrr/.backup_password)

export PASSPHRASE=$ENCRYPTION_PASSPHRASE

for SRC_DIR in "${SRC_DIRS[@]}"; do
  BASENAME=$(basename "$SRC_DIR")
  duplicity backup $SRC_DIR rclone://dropbox:$BASENAME --copy-links
done

unset PASSPHRASE
