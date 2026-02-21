#!/usr/bin/env bash
# travis helpers

if [[ -f "${HOME}/.travis/travis.sh" ]]; then
  # shellcheck source=/dev/null
  . "${HOME}/.travis/travis.sh"
fi

