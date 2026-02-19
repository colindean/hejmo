#!/usr/bin/env bash
# ruby management

if [[ -z ${NO_RVM} ]]; then
  if [[ -s "${HOME}/.rvm/scripts/rvm" ]]; then
    . "${HOME}/.rvm/scripts/rvm" # Load RVM installed locally
  elif [[ -s "/etc/profile.d/rvm.sh" ]]; then
    if ! groups | grep rvm > /dev/null; then
      >&2  echo "${USER} is not in group 'rvm', sourcing /etc/profile.d/rvm.sh may not work as intended."
    fi
    # shellcheck source=/dev/null
    . "/etc/profile.d/rvm.sh"  # Load RVM installed at system level
  fi
fi

if [[ -z ${NO_CHRUBY} ]]; then
  # shellcheck disable=SC2154
  chruby_share="$(${BREW_PREFIX} chruby)/share/chruby"
  if [[ -s "${chruby_share}/chruby.sh" ]]; then
    . "${chruby_share}/chruby.sh"
  fi
  if [[ -s "${chruby_share}/auto.sh" ]]; then
    . "${chruby_share}/auto.sh"
  fi
fi

