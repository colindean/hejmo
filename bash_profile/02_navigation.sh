#!/usr/bin/env bash
# directory navigation

# move up directories quickly instead of cd ../; cd ../; etc/.
# adapted from http://www.bashoneliners.com/oneliners/oneliner/231/
up() {
	DEEP=${1:-"1"}
	OLDPWD_CACHE="${PWD}"
	for _ in $(seq 1 "${DEEP}"); do
		cd ../
	done
	export OLDPWD="${OLDPWD_CACHE}"
}

hejmo() {
	cd "${HEJMO}" || exit
	[[ -n "$(command -v tabname)" ]] && tabname
}
