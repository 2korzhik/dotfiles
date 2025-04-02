#!/usr/bin/env bash

set -e

# Пути
CUSTOM_PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"
ZSHRC_PATH="$HOME/.zshrc"

# Список плагинов и их репы
PLUGINS=(
    "fzf-tab https://github.com/Aloxaf/fzf-tab.git"
    "fzf-zsh-plugin https://github.com/unixorn/fzf-zsh-plugin.git"
    "zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions.git"
    "zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git"
    "zsh-completions https://github.com/zsh-users/zsh-completions.git"
)

echo "Проверка и установка зависимостей..."
for cmd in git curl; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "❌ Не найден $cmd. Установи и попробуй снова." >&2
        exit 1
    fi
done
echo "Есть все зависимости установлены"


echo "1. Устанавливаю Oh My Zsh..."
if [ ! -d "$OH_MY_ZSH_DIR" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo "✅ Oh My Zsh установлен"
else
    echo "✅ Oh My Zsh уже установлен, пропускаю."
fi


echo "2. Создаю директорию $CUSTOM_PLUGINS_DIR для плагинов, если её нет..."
mkdir -p "${CUSTOM_PLUGINS_DIR}"


echo "3. Устанавливаю плагины..."
for plugin in "${PLUGINS[@]}"; do
    NAME=$(echo "$plugin" | cut -d' ' -f1)
    URL=$(echo "$plugin" | cut -d' ' -f2)
    PLUGIN_DIR="${CUSTOM_PLUGINS_DIR}/${NAME}"

    if [ ! -d "${PLUGIN_DIR}" ]; then
        echo "⬇Клонирую $NAME..."
        git clone --depth=1 "$URL" "$PLUGIN_DIR"
    else
        echo "Обновляю $NAME..."
        git -C "${PLUGIN_DIR}" pull --quiet || echo "❌ Не удалось обновить $NAME."
    fi
done


if [ "$SHELL" != "$(which zsh)" ]; then
    echo "4. Меняем дефолтную оболочку на zsh..."
    chsh -s "$(which zsh)"
fi

echo "🎉 Установка zsh завершена! Перезапусти терминал"
