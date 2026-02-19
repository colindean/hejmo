#!/usr/bin/env bash
# hashing functions and aliases

if ! command -v sha256 > /dev/null; then
  alias sha256='shasum -a 256'
fi
if ! command -v sha1 > /dev/null; then
  alias sha1='shasum -a 1'
fi

