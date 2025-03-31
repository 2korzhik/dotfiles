#!/usr/bin/env bash

set -e  # стопаем скрипт при любой ошибке

source ./install_zsh.sh

# Set up symlinks using stow
source ./symlinks.sh

# Update settings
source ~/.zshrc
