#!/bin/bash

case "$(uname -s)" in
  Darwin) LN_OPTIONS="sFh" ;;
  Linux) LN_OPTIONS="sf" ;;
  # TODO: determine safe defaults for OSes I never use
  *) LN_OPTIONS="sf" ;;
esac

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
  ln "-${LN_OPTIONS}" "$TARGET" "$LINK"
done
