#!/usr/bin/env bash
# ruby management

if [[ -z $NO_RVM ]]; then
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
fi

if [[ -z $NO_CHRUBY ]]; then
  chruby_share="$(${BREW_PREFIX} chruby)/share/chruby"
  [[ -s "${chruby_share}/chruby.sh" ]] && . "${chruby_share}/chruby.sh"
  [[ -s "${chruby_share}/auto.sh" ]] && . "${chruby_share}/auto.sh"
fi

