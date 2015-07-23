#!/bin/sh

source _helpers.sh

command_exists "brew"
brew_exists=$?
if [[ $brew_exists -ne 0 ]]; then
  echo >&2 "brew isn't available, installing Homebrew."
  install_homebrew 
fi

command_exists "brew-cask"
brewcask_exists=$?
if [[ $brewcask_exists -ne 0 ]]; then
  echo >&2 "brew-cask isn't available, installing Caskroom."
  brew install caskroom/cask/brew-cask
fi

install_packages "caskroom.list" 'echo brew cask install %PACKAGE%'

# to generate list:
#     brew cask list
