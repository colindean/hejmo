#!/usr/bin/env bash
# load env.local in a way it can be timed

if [[ -s "${HOME}/.env.local" ]]; then
	# shellcheck source=/dev/null
	. "${HOME}/.env.local"
fi
