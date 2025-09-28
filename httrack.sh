#!/usr/bin/env bash

httrack "https://www.openfoundry.org" \
  -O "openfoundry.org" \
  -v \
  --display \
  --robots=0 \
  --retries=3 \
  --depth=10 \
  --continue \
  --update \
  --sockets=4 \
  --assume=no \
  '-*' \
  '+*.openfoundry.org/*' \
  '-*openfoundry.org/sso/user*' \
  '-*of.openfoundry.org*' \
  '-*whoswho.openfoundry.org*' \
  '-*.pdf' '-*.zip' '-*.webm' '-*.mp4' '-*.odp' '-*.ppt' \
  '-*web.archive.org*'
