#!/usr/bin/env bash

set -e

source install_apt_pkgs.sh

source install_kitty.sh

source install_fonts.sh

source ./install_tmux.sh

source install_omz.sh

source ./generate_my_cnf.sh

source ./symlinks.sh

source ~/.zshrc
