#!/usr/bin/env bash

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
MAMBA_EXE="$(${BREW_PREFIX} micromamba)/bin/micromamba"
export MAMBA_EXE
export MAMBA_ROOT_PREFIX="${HOME}/.cache/micromamba"
# Cache for 1 hour (3600 seconds) since mamba configuration may change during development
if __mamba_setup="$(bkt_cache_hourly "$MAMBA_EXE" shell hook --shell bash --prefix "$MAMBA_ROOT_PREFIX" 2>/dev/null)"; then
	#if [ $? -eq 0 ]; then
	eval "$__mamba_setup"
else
	if [ -f "${MAMBA_ROOT_PREFIX}/etc/profile.d/micromamba.sh" ]; then
		# shellcheck source=/dev/null
		. "${MAMBA_ROOT_PREFIX}/etc/profile.d/micromamba.sh"
	else
		export PATH="${MAMBA_ROOT_PREFIX}/bin:${PATH}" # extra space after export prevents interference from conda init
	fi
fi
unset __mamba_setup
# <<< mamba initialize <<<
