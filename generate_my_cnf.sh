#!/usr/bin/env bash

set -e

PLAYBOOK_PATH="ansible/generate_mysql_config.yml"

ansible-playbook --ask-vault-pass "$PLAYBOOK_PATH"