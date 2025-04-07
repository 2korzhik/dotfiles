#!/usr/bin/env bash

TMUX_PLUGIN_DIR="$HOME/.tmux/plugins"

PLUGINS=(
    "tpm https://github.com/tmux-plugins/tpm.git"
)

for plugin in "${PLUGINS[@]}"; do
    NAME=$(echo "$plugin" | cut -d' ' -f1)
    URL=$(echo "$plugin" | cut -d' ' -f2)
    PLUGIN_DIR="${TMUX_PLUGIN_DIR}/${NAME}"

    if [ ! -d "${PLUGIN_DIR}" ]; then
        git clone --depth=1 "$URL" "$PLUGIN_DIR"
    else
        git -C "${PLUGIN_DIR}" pull --quiet || echo "WARNING!!! unable to update $NAME."
    fi
done
