#!/bin/bash

echo '{}' | jq ".i = \"$MISSKEY_TOKEN\" | .text = \"Pariring 인스턴스 업데이트가 시작되었습니다.\\n버전: \($(cat ../version))\" | .visibility = \"home\"" > ../content.json
