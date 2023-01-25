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

git push "https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" state

function update {
  cd ../updater
  VERSION=$(bash ./set-version.sh) bash ./generate-body.sh

  curl -X POST --data "$(cat ../content.json)" -H "Content-Type: application/json" https://pikokr.dev/api/notes/create

  echo "" > ../is_updated
}

if test -f prev; then
  if [[ $(< current) != $(< prev) ]]; then
    update
  fi
else
  update
fi
