#!/usr/bin/env bash

# Пути
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Список папок с конфигами для stow
CONFIGS=("bash" "git" "tmux" "vim" "zsh" "terminal")

command -v stow >/dev/null 2>&1 || { echo "stow не установлен"; exit 1; }

echo "🟢 Устанавливаю конфиги через stow..."
cd "${DOTFILES_DIR}"
for config in "${CONFIGS[@]}"; do
    echo "Stowing $config..."
    if stow --adopt --dotfiles -v "$config"; then
        echo "✅ $config успешно установлен."
    else
        echo "❌ Ошибка при установке $config." >&2
    fi
done
