#!/usr/bin/env bash

# Completions from OS
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# Completions from Homebrew

if [ -n "$(command -v brew)" ]; then
	if [ -n "${HEJMO_DEBUG_COMPLETIONS}" ]; then
		set -x
	fi

	# completions
	HOMEBREW_PREFIX="$(${BREW_PREFIX})"
	export HOMEBREW_COMPLETIONS_DIR="${HOMEBREW_PREFIX}/etc/bash_completion.d"
	export BASH_COMPLETION_COMPAT_DIR="${HOMEBREW_COMPLETIONS_DIR}"
	HOMEBREW_PROF_COMPLETION_SCRIPT="${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
	export HOMEBREW_SOURCE_COMPLETIONS=yes

	if [ -n "${HEJMO_DEBUG_COMPLETIONS}" ]; then
		set +x
	fi

	# shellcheck source=/dev/null
	if [ -f "${HOMEBREW_PROF_COMPLETION_SCRIPT}" ]; then
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
# shellcheck source=../scripts/_t_completion
if [ -n "$(command -v t)" ]; then
	if [ -n "$(command -v _t_completion)" ]; then
		source "$(command -v _t_completion)"
	fi
fi

# autocomplete for pandoc
if [ -n "$(command -v pandoc)" ]; then
	# Cache for 1 day (86400 seconds) since pandoc completion rarely changes
	eval "$(bkt --ttl=86400 -- pandoc --bash-completion)"
fi

# autocomplete for ngrok
if [ -n "$(command -v ngrok)" ]; then
	# Cache for 1 day (86400 seconds) since ngrok completion rarely changes
	eval "$(bkt --ttl=86400 -- ngrok completion)"
fi
