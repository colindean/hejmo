#!/usr/bin/env bash
# string manipulation functions

# https://stackoverflow.com/a/3352015
function trim() {
	local var="${*}"
	# read -rd '' var <<<"$var" || :
	(($#)) || read -re var
	var="${var#"${var%%[![:space:]]*}"}" # remove leading whitespace characters
	var="${var%"${var##*[![:space:]]}"}" # remove trailing whitespace characters
	echo -n "$var"
}

alias eo="eoconv --from=post-x --to=utf-8"
