#!/usr/bin/env bash
# rust management

if [[ -f "${HOME}/.cargo/env" ]]; then
	# shellcheck source=/dev/null
	source "${HOME}/.cargo/env"
fi
