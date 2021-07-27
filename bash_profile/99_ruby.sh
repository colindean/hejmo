#!/usr/bin/env bash
# ruby management

if [[ -z $NO_RVM ]]; then
  if [ -s "$HOME/.rvm/scripts/rvm" ]; then
    "$HOME/.rvm/scripts/rvm" # Load RVM function
  fi
fi

if [[ -z $NO_CHRUBY ]]; then
  chruby_share="$(${BREW_PREFIX} chruby)/share/chruby"
  if [ -s "${chruby_share}/chruby.sh" ]; then
    "${chruby_share}/chruby.sh"
  fi
  if [ -s "${chruby_share}/auto.sh" ]; then
    . "${chruby_share}/auto.sh"
  fi
fi

