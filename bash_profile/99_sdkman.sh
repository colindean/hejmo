#!/usr/bin/env bash

# shellcheck disable=SC2154
HB_SDKMAN_PATH="${HB_SDKMAN_PATH:-"$(${BREW_PREFIX})/opt/sdkman-cli/libexec"}"

SDKMAN_INIT="${HB_SDKMAN_PATH}/bin/sdkman-init.sh"

if [[ -f "${SDKMAN_INIT}" ]] && [[ -d "${SDKMAN_DIR}" ]]; then
	# shellcheck source=/dev/null
	source "${SDKMAN_INIT}"
fi
