#!/usr/bin/env bash

shellcheck_wiki() {
  local ARTICLE="${1}"
  local BASE_URL="https://github.com/koalaman/shellcheck/wiki"
  local GO_URL="${BASE_URL}/${ARTICLE}"
  if [ -n "$(command -v xdg-open)" ]; then
    xdg-open "${GO_URL}"
  else
    open "${GO_URL}"
  fi
}

alias scw="shellcheck_wiki"
