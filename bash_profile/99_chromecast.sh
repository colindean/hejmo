#!/usr/bin/env bash
# chromecasting functions

function ccyt {
  curl -H "Content-Type: application/json" \
    http://"Basement TV.local":8008/apps/YouTube \
    -X POST \
    -d "v=$1";
}

function ytsearch() {
  curl -s "https://www.youtube.com/results?search_query=$*" | \
    grep -o 'watch?v=[^"]*"[^>]*title="[^"]*' | \
    sed -e 's/^watch\?v=\([^"]*\)".*title="\(.*\)/\1 \2/g'
}

# maybe use this instead? https://github.com/skorokithakis/catt

