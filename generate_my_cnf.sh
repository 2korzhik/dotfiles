#!/usr/bin/env bash

set -e

PLAYBOOK_PATH="ansible/generate_mysql_config.yml"

if ! command -v ansible-playbook &> /dev/null; then
    echo "Ansible не установлен. Установи его командой:"
    echo "  pip install ansible"
    exit 1
fi

echo "Ansible установлен. Запускаю плейбук..."

ansible-playbook --ask-vault-pass "$PLAYBOOK_PATH"