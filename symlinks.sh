#!/usr/bin/env bash

set -e  # Останавливаем скрипт при любой ошибке


# Пути
DOTFILES_DIR="$HOME/dotfiles"

# Список папок с конфигами для stow
CONFIGS=("bash" "git" "tmux" "vim" "zsh")

command -v stow >/dev/null 2>&1 || { echo "stow не установлен"; exit 1; }

echo "Устанавливаю конфиги через stow..."
cd "${DOTFILES_DIR}"
for config in "${CONFIGS[@]}"; do
    echo "Stowing $config..."
    if stow --adopt --dotfiles -v "$config"; then
        echo "✅ $config успешно установлен."
    else
        echo "❌ Ошибка при установке $config." >&2
    fi
done

echo "🎉 Симлинки на конфиги созданы!"

