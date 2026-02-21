#!/usr/bin/env bash
# gradle functions and aliases

alias gradle="gw --daemon"
alias gw="gw --daemon"

if [[ -s "${HOME}/.gvm/bin/gvm-init.sh" ]]; then
	"${HOME}/.gvm/bin/gvm-init.sh"
fi
