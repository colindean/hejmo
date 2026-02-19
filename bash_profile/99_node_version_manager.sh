#!/usr/bin/env bash

export NVM_DIR="${HOME}/.cache/nvm"

if [[ -z "${BREW_PREFIX}" ]]; then
	echo >&2 "ERROR: BREW_PREFIX is not set"
	exit 1
fi
NVM_PREFIX="$(${BREW_PREFIX} nvm)"
NVM_BASE="${NVM_PREFIX}/nvm.sh"
NVM_COMP="${NVM_PREFIX}/etc/bash_completion.d/nvm"

if [[ -s "${NVM_BASE}" ]]; then
	mkdir -p "${NVM_DIR}"
	# shellcheck source=/dev/null
	. "${NVM_BASE}"
fi

if [[ -s "${NVM_COMP}" ]]; then
	# shellcheck source=/dev/null
	. "${NVM_COMP}"
fi
