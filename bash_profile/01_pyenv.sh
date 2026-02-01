#!/usr/bin/env bash

# This used to be in 00_path but I want to time it separately.

if command -v pyenv >/dev/null; then
	# Cache for 1 hour (3600 seconds) since pyenv configuration may change during development
	eval "$(bkt --ttl=3600 -- pyenv init --path)" &&
		eval "$(bkt --ttl=3600 -- pyenv init - "$(basename "${SHELL}")")"
	if pyenv virtualenv-init >/dev/null 2>&1; then
		eval "$(bkt --ttl=3600 -- pyenv virtualenv-init -)"
	fi
fi
