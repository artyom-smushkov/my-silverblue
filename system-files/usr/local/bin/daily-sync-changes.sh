#!/bin/bash

cd ~/Dotfiles
git pull
stow .

daily-install.sh
