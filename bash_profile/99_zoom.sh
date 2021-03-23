#!/usr/bin/env bash
# functions to make zoom more bearable

function zoom_join() {
  local meeting_id="${1}"
  local url="zoommtg://zoom.us/join?action=join&confno=${meeting_id}"
  echo "Opening ${url}…"
  if [ -n "$(command -v xdg-open)" ]; then
    # Linux
    xdg-open "${url}"
  else
    # macOS
    open "${url}"
  fi
}

alias zoom="zoom_join"
