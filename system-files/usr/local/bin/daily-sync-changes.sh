#!/bin/bash

cd ~/Dotfiles
git pull
stow .

brew update
brew bundle install --cleanup --file /var/home/templarrr/.config/brewfile/Brewfile --no-lock
brew upgrade

daily-install.sh
