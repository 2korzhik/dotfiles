#!/usr/bin/env bash

CUSTOM_PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"
ZSHRC_PATH="$HOME/.zshrc"

PLUGINS=(
    "fzf-tab https://github.com/Aloxaf/fzf-tab.git"
    "fzf-zsh-plugin https://github.com/unixorn/fzf-zsh-plugin.git"
    "zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions.git"
    "zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git"
    "zsh-completions https://github.com/zsh-users/zsh-completions.git"
    "zsh-shift-select https://github.com/jirutka/zsh-shift-select.git"
)

echo "🟢 1. install Oh My Zsh..."
if [ ! -d "$OH_MY_ZSH_DIR" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "🟢 2. install plugins..."
for plugin in "${PLUGINS[@]}"; do
    NAME=$(echo "$plugin" | cut -d' ' -f1)
    URL=$(echo "$plugin" | cut -d' ' -f2)
    PLUGIN_DIR="${CUSTOM_PLUGINS_DIR}/${NAME}"

    if [ ! -d "${PLUGIN_DIR}" ]; then
        git clone --depth=1 "$URL" "$PLUGIN_DIR"
    else
        git -C "${PLUGIN_DIR}" pull --quiet || echo "WARNING!!! unable to update $NAME."
    fi
done

echo "🟢 3. install oh-my-posh..."
curl -s https://ohmyposh.dev/install.sh | bash -s
export PATH="$HOME/.local/bin:$PATH"

echo "🟢 4. install fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
sh -c "~/.fzf/install --no-fish --no-bash --key-bindings --completion --no-update-rc"

echo "🟢 5. install uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh