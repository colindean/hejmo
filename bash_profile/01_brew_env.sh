#!/usr/bin/env bash

if [[ "Linux" = "$(uname -s)" ]]; then
  export HOMEBREW_CASK_OPTS="--appdir=/dev/null --fontdir=${HOME}/.fonts"
fi

XDG_DATA_DIRS="$(__determine_brew_path)/share:${XDG_DATA_DIRS}"
export XDG_DATA_DIRS

