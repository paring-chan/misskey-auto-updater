#!/bin/bash

PREV=$(cat ../state/prev)
CURR=$(cat ../state/current)

echo '{}' | jq ".i = \"$MISSKEY_TOKEN\" | .text = \"Pariring 인스턴스 업데이트가 시작되었습니다.\\n버전: ($(cat ../version))\\n변경사항: [클릭](https://github.com/misskey-dev/misskey/compare/$PREV...$CURR)\" | .visibility = \"home\"" > ../content.json
