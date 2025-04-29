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
  git reflog expire --expire=now --all
  git gc --prune=now --aggressive

  cd ../

  tar -czf "$ARCHIVE_PATH" "$TARGET_DIR"

  echo "INFO: Success! Archive location: $ARCHIVE_PATH"
}