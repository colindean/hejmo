#!/usr/bin/env bash

# setup zoxide
THIS_SHELL="$(basename "${SHELL}")"

if true && command -v zoxide >/dev/null; then
	# Cache for 1 day (86400 seconds) since zoxide init output rarely changes
	case "${THIS_SHELL}" in
	bash)
		# shellcheck disable=SC2312
		eval "$(bkt_cache_daily zoxide init bash)"
		;;
	zsh)
		# shellcheck disable=SC2312
		eval "$(bkt_cache_daily zoxide init zsh)"
		;;
	*)
		# shellcheck disable=SC2312
		eval "$(bkt_cache_daily zoxide init posix --hook prompt)"
		;;
	esac
fi

# because the zoxide thing messes this up
export PROMPT_COMMAND="${PROMPT_COMMAND/;;/;}"
