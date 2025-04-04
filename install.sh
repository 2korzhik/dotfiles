#!/usr/bin/env zsh

set -e

source install_apt_pkgs.sh

source ./install_tmux.sh

source ./install_zsh.sh

source ./generate_my_cnf.sh

source ./symlinks.sh

source ~/.zshrc
