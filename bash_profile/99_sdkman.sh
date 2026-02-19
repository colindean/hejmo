#!/usr/bin/env bash

if [[ -z "${BREW_PREFIX}" ]]; then
	echo >&2 "ERROR: BREW_PREFIX is not set"
	exit 1
fi
HB_SDKMAN_PATH="${HB_SDKMAN_PATH:-"$(${BREW_PREFIX})/opt/sdkman-cli/libexec"}"

SDKMAN_INIT="${HB_SDKMAN_PATH}/bin/sdkman-init.sh"

if [[ -z "${SDKMAN_DIR}" ]]; then
	echo >&2 "WARNING: SDKMAN_DIR is not set, skipping SDKMAN initialization"
elif [[ -f "${SDKMAN_INIT}" ]] && [[ -d "${SDKMAN_DIR}" ]]; then
	# shellcheck source=/dev/null
	source "${SDKMAN_INIT}"
fi
