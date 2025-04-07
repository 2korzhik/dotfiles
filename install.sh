#!/usr/bin/env bash

sudo ./install_apt_pkgs.sh

source install_kitty.sh

source install_fonts.sh

source install_tmux.sh

source install_omz.sh

source generate_my_cnf.sh

source symlinks.sh

if [ "$SHELL" != "$(which zsh)" ]; then
    echo "switch shell to zsh..."
    chsh -s "$(which zsh)"
fi
source ~/.zshrc
