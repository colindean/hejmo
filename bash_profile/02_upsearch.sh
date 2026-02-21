#!/bin/bash
# upsearch

#props to @PaulSCoder and @joelmccracken for this wizardry

UPSEARCH_FOUND=0
UPSEARCH_NOT_FOUND=127

upsearch_cd_old() {
	# if we're at root and the file's not here, return not found
	# if the file is in the present working directory, echo the directory and return found
	# otherwise go up a directory and execute recursively
	# this could get slow if 'cd' is bound to something slow and not a simple changing of pwd
	test / == "${PWD}" && test ! -e "$1" && return "${UPSEARCH_NOT_FOUND}" || test -e "$1" && echo "${PWD}" && return "${UPSEARCH_FOUND}" || cd .. && upsearch_cd "$1"
}

upsearch_old() {
	(upsearch_cd "$1")
}

upsearch_cd() {
	where=$(upsearch "$1")
	result=$?
	if [[ ${result} -eq ${UPSEARCH_FOUND} ]]; then
		if ! cd "${where}"; then
			echo >&2 "Failed to change directory to ${where}"
			return 1
		fi
	elif [[ ${result} -eq ${UPSEARCH_NOT_FOUND} ]]; then
		echo >&2 "$1 not found in path"
	else
		echo >&2 "upsearch returned something weird: ${result}"
	fi
}

# adapted from gdub's lookup() function:
# https://github.com/dougborg/gdub/blob/70ed1d774ad3f9cbe03041aa81164c81e11003cb/bin/gw#L12
upsearch() {
	local file="${1}"
	local curr_path="${2}"
	[[ -z "${curr_path}" ]] && curr_path="${PWD}"

	# Search recursively upwards for file.
	until [[ "${curr_path}" == "/" ]]; do
		if [[ -e "${curr_path}/${file}" ]]; then
			echo "${curr_path}"
			return "${UPSEARCH_FOUND}"
		else
			curr_path=$(dirname "${curr_path}")
		fi
	done
	return "${UPSEARCH_NOT_FOUND}"
}
