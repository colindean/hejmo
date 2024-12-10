#!/usr/bin/env bash
# string manipulation functions

function trim() {
	local var=${*}
	var="${var#"${var%%[![:space:]]*}"}" # remove leading whitespace characters
	var="${var%"${var##*[![:space:]]}"}" # remove trailing whitespace characters
	echo -n "$var"
}

alias eo="eoconv --from=post-x --to=utf-8"
