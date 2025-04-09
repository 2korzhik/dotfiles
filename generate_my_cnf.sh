#!/usr/bin/env bash

PLAYBOOK_PATH="ansible/generate_mysql_config.yml"
MAX_ATTEMPTS=3

echo "🟢 Для генерации .my.cnf введите пароль к Ansible Vault."

for ((attempt = 1; attempt <= MAX_ATTEMPTS; attempt++)); do
  set +e  # отключаем "exit on error"
  ansible-playbook --ask-vault-pass "$PLAYBOOK_PATH"
  EXIT_CODE=$?
  set -e  # включаем обратно

  if [[ $EXIT_CODE -eq 0 ]]; then
    echo "✅ Конфиг успешно сгенерирован."
    break
  else
    echo "❌ Неверный пароль или ошибка. Попробуйте снова."
  fi

  if [[ $attempt -eq $MAX_ATTEMPTS ]]; then
    echo "Превышено количество попыток. Пропускаю генерацию конфига."
  else
    ((remaining_attempts = MAX_ATTEMPTS - attempt))
    echo "Попыток осталось: $remaining_attempts..."
  fi
done