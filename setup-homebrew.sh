#!/bin/sh

. _helpers.sh

command_exists "brew"
brew_exists=$?
if [ $brew_exists -ne 0 ]; then
  echo >&2 "brew isn't available, installing Homebrew."
  install_homebrew
fi

