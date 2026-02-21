#!/usr/bin/env bash

# Completions from OS
if ! shopt -oq posix; then
	if [[ -f /usr/share/bash-completion/bash_completion ]]; then
		# shellcheck source=/dev/null
		. /usr/share/bash-completion/bash_completion
	elif [[ -f /etc/bash_completion ]]; then
		# shellcheck source=/dev/null
		. /etc/bash_completion
	fi
fi

# Completions from Homebrew

if command -v brew > /dev/null; then
	if [[ -n "${HEJMO_DEBUG_COMPLETIONS}" ]]; then
		set -x
	fi

	# completions
	# shellcheck disable=SC2154
	HOMEBREW_PREFIX="$(${BREW_PREFIX})"
	export HOMEBREW_COMPLETIONS_DIR="${HOMEBREW_PREFIX}/etc/bash_completion.d"
	export BASH_COMPLETION_COMPAT_DIR="${HOMEBREW_COMPLETIONS_DIR}"
	HOMEBREW_PROF_COMPLETION_SCRIPT="${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
	export HOMEBREW_SOURCE_COMPLETIONS=yes

	if [[ -n "${HEJMO_DEBUG_COMPLETIONS}" ]]; then
		set +x
	fi

	# shellcheck source=/dev/null
	if [[ -f "${HOMEBREW_PROF_COMPLETION_SCRIPT}" ]]; then
		# use the bash completion loader from the bash-completion package
		source "${HOMEBREW_PROF_COMPLETION_SCRIPT}"
	else
		# load them manually
		for COMPLETION in "${HOMEBREW_COMPLETIONS_DIR}/"*; do
			[[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
		done
	fi
fi

#autocomplete for g as well
#complete -o default -o nospace -F _git g
#if [ -n "$(command -v __git_complete)" ]; then
#  __git_complete g git
#fi

#autocomplete for t
if command -v t > /dev/null; then
	if command -v _t_completion > /dev/null; then
		# shellcheck source=/dev/null disable=SC2312
		source "$(command -v _t_completion)"
	fi
fi

# autocomplete for pandoc
if command -v pandoc > /dev/null; then
	# Cache for 1 day (86400 seconds) since pandoc completion rarely changes
	# shellcheck disable=SC2312
	eval "$(bkt_cache_daily pandoc --bash-completion)"
fi

# autocomplete for ngrok
if command -v ngrok > /dev/null; then
	# Cache for 1 day (86400 seconds) since ngrok completion rarely changes
	# shellcheck disable=SC2312
	eval "$(bkt_cache_daily ngrok completion)"
fi
