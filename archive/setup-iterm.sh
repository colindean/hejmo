#!/usr/bin/env bash

if [[ -z "${HEJMO}" ]]; then
  echo >&2 "HEJMO is unset, so this script cannot determine the directory to which it should point iTerm2 for its configuration."
  echo >&2 "Setup Hejmo, eh?"
  exit 1
fi

ITERM_BUNDLE="com.googlecode.iterm2"
ITERM_PREFS="${HEJMO}/iterm"

echo "Configuring iTerm2 as specified in ${ITERM_PREFS}…"

# make double sure that it's installed
brew bundle --file="${ITERM_PREFS}/Brewfile.iterm"

# set the default governing its preferences file
defaults write "${ITERM_BUNDLE}" PrefsCustomFolder "${ITERM_PREFS}"

echo "Done. Opening iTerm, which should be restarted if it was already open."

open -b "${ITERM_BUNDLE}"
