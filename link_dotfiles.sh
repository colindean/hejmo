#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DOTFILES_DIR="${SCRIPT_DIR}/dotfiles"

for f in $(ls ${DOTFILES_DIR}); do
  TARGET="${DOTFILES_DIR}/${f}"
  LINK="${HOME}/.${f}"
  if [[ ! -z $RM ]]; then
    echo "Removing $LINK"
    rm -f "$LINK"
  fi
  echo "Linking $LINK to $TARGET"
  ln -s "$TARGET" "$LINK" 
done
