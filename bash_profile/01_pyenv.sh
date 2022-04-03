#!/usr/bin/env bash

# This used to be in 00_path but I want to time it separately.

if command -v pyenv >/dev/null; then
  eval "$(pyenv init --path)" && \
    eval "$(pyenv init -)"
  if pyenv virtualenv-init > /dev/null 2>&1; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi
