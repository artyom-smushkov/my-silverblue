#!/bin/bash

cd ~/Dotfiles
git pull
stow . --no-folding

daily-install.sh
