#!/bin/bash

cd misskey

if test -f ../state/current; then
  cp ../state/current ../state/prev
fi

cd ../misskey && git rev-parse HEAD | tee ../state/current

cd ../state

git add .

git config user.name github-actions[bot]

git config user.email github-actions[bot]@users.noreply.github.com

git commit -m 'update version' || echo 'nothing to commit'

git remote set-url origin "https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${REPOSITORY}.git"

git push

function update {
  cd ../updater
  bash ./set-version.sh

  echo "" > ../is_updated
}

if test -f prev; then
  if [[ $(< current) != $(< prev) ]]; then
    update
  fi
else
  update
fi
