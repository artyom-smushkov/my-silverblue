#!/bin/bash

daily-install.sh

cd ~/Dotfiles
git pull
stow .
