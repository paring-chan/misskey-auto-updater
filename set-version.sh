#!/bin/bash

cd ../misskey

SHA=$(git rev-parse --short HEAD)

cd ../updater

VERSION="$(cat ../misskey/package.json | jq .version -r)-$(echo -n $SHA)"

cat ../misskey/package.json | jq ".version=\"$VERSION\"" | tee ../misskey/package.json

sed -i -e 's/ && compareVersions.*1//g' ../misskey/packages/frontend/src/init.ts

echo -n $VERSION > ../version
