#!/usr/bin/env bash

set -e  # стопаем скрипт при любой ошибке

# Путь к плейбуку
PLAYBOOK_PATH="ansible/generate_mysql_config.yml"

# Проверка, установлен ли Ansible
if ! command -v ansible-playbook &> /dev/null; then
    echo "Ansible не установлен. Установи его командой:"
    echo "  pip install ansible"
    exit 1
fi

echo "Ansible установлен. Запускаю плейбук..."

# Запуск плейбука
ansible-playbook --ask-vault-pass "$PLAYBOOK_PATH"