#!/usr/bin/env bash
# rust management

RUSTUP_BIN="$(brew --prefix rustup)/bin"
if [[ -d "${RUSTUP_BIN}" ]]; then
	export PATH="${RUSTUP_BIN}:${PATH}"
fi

if [[ -f "${HOME}/.cargo/env" ]]; then
	# shellcheck source=/dev/null
	source "${HOME}/.cargo/env"
fi


