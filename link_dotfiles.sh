#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DOTFILES_DIR="${SCRIPT_DIR}/dotfiles"

for f in $(ls ${DOTFILES_DIR}); do
  ln -s "${DOTFILES_DIR}/${f}" "${HOME}/.${f}"
done
