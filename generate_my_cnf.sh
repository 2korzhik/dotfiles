#!/usr/bin/env bash

set -euo pipefail

PLAYBOOK_PATH="ansible/generate_mysql_config.yml"
MAX_ATTEMPTS=3

echo "Для генерации .my.cnf введите пароль к Ansible Vault."

for ((attempt = 1; attempt <= MAX_ATTEMPTS; attempt++)); do
  echo "Попытка $attempt из $MAX_ATTEMPTS..."
  if ansible-playbook --ask-vault-pass "$PLAYBOOK_PATH"; then
    echo "Конфиг успешно сгенерирован."
    break
  else
    echo "❌ Неверный пароль или ошибка. Попробуйте снова."
  fi

  if [[ $attempt -eq $MAX_ATTEMPTS ]]; then
    echo "Превышено количество попыток. Пропускаю генерацию конфига."
  fi
done