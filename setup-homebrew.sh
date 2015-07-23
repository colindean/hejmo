#!/bin/sh

source _helpers.sh

command_exists "brew"
brew_exists=$?
if [[ $brew_exists -ne 0 ]]; then
  echo >&2 "brew isn't available, installing Homebrew."
  install_homebrew 
fi
  
install_packages "homebrew.list" "echo brew install %PACKAGE%"

# to generate list:
#     brew leaves
