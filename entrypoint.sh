#!/usr/bin/env bash

echo "Running linter"
CHANGE_LIST=$(git diff "${GITHUB_BASE_REF}".."${GITHUB_HEAD_REF}" --name-only | grep '.go$')

echo "git diff \"${GITHUB_BASE_REF}\"..\"${GITHUB_HEAD_REF}\" --name-only"
echo "changelist: $CHANGE_LIST"

if [ -z "$CHANGE_LIST" ]; then
  echo "No changes in .go files, exiting"
  exit 0;
fi

DIRS=""

for f in $CHANGE_LIST; do
  DIRS+="$(dirname "${f}")\n"
done

UNIQ_DIRS=$(echo -e $DIRS | sort -u)
which golangci-lint
echo "uniq dirs: ${UNIQ_DIRS}"
echo "running binary"

golangci-lint run --verbose --out-format github-actions \
  --new-from-rev "${GITHUB_BASE_REF}" --modules-download-mode vendor --fast $UNIQ_DIRS
echo "lint exited with $?"