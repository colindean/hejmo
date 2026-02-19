#!/usr/bin/env bash
# hashing functions and aliases

if [[ -z "$(command -v sha256)" ]]; then
  alias sha256='shasum -a 256'
fi
if [[ -z "$(command -v sha1)" ]]; then
  alias sha1='shasum -a 1'
fi

