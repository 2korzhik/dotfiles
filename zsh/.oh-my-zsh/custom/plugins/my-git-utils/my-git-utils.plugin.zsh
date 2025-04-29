#!/usr/bin/env bash

function git-master-archive() {
  if [ -z "$1" ]; then
    echo "ERROR: Usage: git-master-archive /path/to/git/project"
    return 1
  fi

  local TARGET_DIR="$1"

  if [ ! -d "$TARGET_DIR/.git" ]; then
    echo "ERROR: Path must be a git repository: $TARGET_DIR"
    return 2
  fi

  TARGET_PATH="$(realpath "$TARGET_DIR")"
  local REPO_NAME="$(basename "$TARGET_DIR")"
  local DATE="$(date +%F)"
  local ARCHIVE_NAME="${REPO_NAME}_${DATE}.tar.gz"
  local ARCHIVE_PATH="$(dirname ".")/$ARCHIVE_NAME"

  cd "$TARGET_PATH" || return

  git checkout master

  local MERGED_BRANCHES
  MERGED_BRANCHES=$(git branch --merged master | grep -vE '^\*|master' || true)

  if [ -n "$MERGED_BRANCHES" ]; then
    echo "$MERGED_BRANCHES" | while read -r branch; do
      git branch -d "$branch"
    done
  else
    echo "INFO: no branches to delete"
  fi

  git clean -xfd
  rm -rf .git/refs/remotes/origin/*
  rm -rf .git/logs/refs/remotes/origin/*
  sed -i '/refs\/remotes\/origin\//d' .git/packed-refs 2>/dev/null || true
  git reflog expire --expire=now --all
  git gc --prune=now --aggressive

  tar --exclude='*.zip' -czf "../$ARCHIVE_PATH" .

  cd ../

  echo "INFO: Success! Archive location: ../$ARCHIVE_PATH"
}


function git-rewrite-br() {
  if ! command -v git-filter-repo &>/dev/null; then
    echo "git-filter-repo package not found"
    return 1
  fi

  local git_name git_email
  git_name=$(git config user.name)
  git_email=$(git config user.email)

  if [ -z "$git_name" ] || [ -z "$git_email" ]; then
    echo "ERROR: no name and email set in git config"
    return 2
  fi

  echo "START BR-N..."

  PYTHONPATH=. git filter-repo \
    --force \
    --message-callback '
import re
from collections import OrderedDict
import subprocess

pattern = re.compile(rb"[a-zA-Z]{2,}-\d+", re.IGNORECASE)
unique_tags = OrderedDict()

log = subprocess.run(["git", "log", "--pretty=format:%B"], capture_output=True, check=True)
for line in log.stdout.splitlines():
    for match in re.finditer(pattern, line):
        tag = match.group().upper()
        if tag not in unique_tags:
            unique_tags[tag] = None

for i, key in enumerate(sorted(unique_tags), start=1):
    unique_tags[key] = f"BR-{i}".encode("utf-8")

def replace(match):
    tag = match.group().upper()
    return unique_tags.get(tag, match.group())

return pattern.sub(replace, message)
' \
    --name-callback "return '$git_name'.encode('utf-8')" \
    --email-callback "return '$git_email'.encode('utf-8')"

  echo "END BR-N..."
}
