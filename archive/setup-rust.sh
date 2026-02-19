#!/bin/bash
source "$HEJMO/scripts/sleep_utils.sh"
e=$?
if [[ $e -ne 0 ]]; then
  echo "Unable to load sleep_utils, errors might suck…"
fi

brew_bin=$(command -v brew)
if [[ -z "$brew_bin" ]]; then
  echo -n "Homebrew is not available and must be for this script to work without errors. Continuing in "
  sleepFor 5
fi

if [[ -d "$(brew --prefix rust)" ]]; then
  echo -n "Removing rust homebrew package because it conflicts with rustup. Continuing in "
  sleepFor 5
  brew uninstall rust
fi

echo "Installing rustup in "
sleepFor 2

curl https://sh.rustup.rs -sSf | sh

echo "Installing rustup completions in "
sleepFor 2
rustup completions bash > "$(brew --prefix)/etc/bash_completion.d/rustup.bash-completion"
