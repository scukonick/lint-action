#!/usr/bin/env bash

ls $GITHUB_WORKSPACE
pwd
cd "$GITHUB_WORKSPACE" || exit 1

echo "Running linter"
CHANGE_LIST=$(git diff "${GITHUB_BASE_REF}".."${GITHUB_HEAD_REF}" --name-only | grep '.go$')

if [ -z "$CHANGE_LIST" ]; then
  echo "No changes in .go files, exiting"
  exit 0;
fi

DIRS=""

for f in $CHANGE_LIST; do
  DIRS+="$(dirname "${f}")\n"
done

UNIQ_DIRS=$(echo -e $DIRS | sort -u)
golangci-lint run --new-from-rev HEAD --modules-download-mode vendor --fast $UNIQ_DIRS