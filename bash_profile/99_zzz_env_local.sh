#!/usr/bin/env bash
# load env.local in a way it can be timed

if [[ -s "${HOME}/.env.local" ]]; then
  . "${HOME}/.env.local"
fi

