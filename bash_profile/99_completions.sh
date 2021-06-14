#!/usr/bin/env bash

if [ -n "$(command -v brew)" ]; then
  # completions
  HOMEBREW_PREFIX="$(${BREW_PREFIX})"
  export HOMEBREW_COMPLETIONS_DIR="${HOMEBREW_PREFIX}/etc/bash_completion.d"
  export BASH_COMPLETION_COMPAT_DIR="${HOMEBREW_COMPLETIONS_DIR}"
  HOMEBREW_PROF_COMPLETION_SCRIPT="${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  export HOMEBREW_SOURCE_COMPLETIONS=yes
  # shellcheck source=/dev/null
  [[ -f "${HOMEBREW_PROF_COMPLETION_SCRIPT}" ]] && . "${HOMEBREW_PROF_COMPLETION_SCRIPT}"
fi

#autocomplete for g as well
#complete -o default -o nospace -F _git g
#if [ -n "$(command -v __git_complete)" ]; then
#  __git_complete g git
#fi

#autocomplete for t
# shellcheck source=../scripts/_t_completion
[[ -n "$(command -v t)" ]] && [[ -n "$(command -v _t_completion)" ]] && source "$(command -v _t_completion)"

# autocomplete for pandoc
[[ -n "$(command -v pandoc)" ]] && eval "$(pandoc --bash-completion)"

