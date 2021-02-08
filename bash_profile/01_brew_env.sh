#!/usr/bin/env bash

if [[ "Linux" = "$(uname -s)" ]]; then
  export HOMEBREW_CASK_OPTS="--appdir=/dev/null --fontdir=${HOME}/.fonts"
fi

