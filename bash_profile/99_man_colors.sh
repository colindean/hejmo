#!/bin/sh
# manpage colors

#https://russellparker.me/2018/02/23/adding-colors-to-man/

export MANROFFOPT='-c'

if echo "${-}" | grep -q i; then
	export LESS_TERMCAP_mb
	LESS_TERMCAP_mb="$(
		tput bold
		tput setaf 2
	)"
	export LESS_TERMCAP_md
	LESS_TERMCAP_md="$(
		tput bold
		tput setaf 6
	)"
	export LESS_TERMCAP_me
	LESS_TERMCAP_me="$(tput sgr0)"
	export LESS_TERMCAP_so
	LESS_TERMCAP_so="$(
		tput bold
		tput setaf 3
		tput setab 4
	)"
	export LESS_TERMCAP_se
	LESS_TERMCAP_se="$(
		tput rmso
		tput sgr0
	)"
	export LESS_TERMCAP_us
	LESS_TERMCAP_us="$(
		tput smul
		tput bold
		tput setaf 7
	)"
	export LESS_TERMCAP_ue
	LESS_TERMCAP_ue="$(
		tput rmul
		tput sgr0
	)"
	export LESS_TERMCAP_mr
	LESS_TERMCAP_mr="$(tput rev)"
	export LESS_TERMCAP_mh
	LESS_TERMCAP_mh="$(tput dim)"
fi
