#!/usr/bin/env bash

sudo ./install_essentials.sh

source install_kitty.sh

source install_fonts.sh

source install_tmux.sh

source install_omz.sh

source generate_my_cnf.sh

source symlinks.sh

git reset --hard

TPM_PATH="${HOME}/.tmux/plugins/tpm"
sh -c "$TPM_PATH/bin/install_plugins"

if [ "$SHELL" != "$(which zsh)" ]; then
    echo "switch shell to zsh..."
    chsh -s "$(which zsh)"
fi

echo "🎉 Всё, теперь тебе нужно разлогиниться. Выйди и зайди по нормальному."