#!/usr/bin/env zsh

set -e  # стопаем скрипт при любой ошибке

source ./install_zsh.sh

source ./generate_my_cnf.sh

# Set up symlinks using stow
source ./symlinks.sh

# Update settings
source ~/.zshrc
