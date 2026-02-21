#!/usr/bin/env bash

install_shfmt() {
	# if we have brew, use it
	if command -v brew >/dev/null; then
		brew install shfmt
		return
	fi
	# we have apt, use it
	if ! (sudo apt-get update --yes && sudo apt-get install --yes --no-install-recommends shfmt); then
		if command -v go >/dev/null; then
			# we've got go, install latest through go
			go install mvdan.cc/sh/v3/cmd/shfmt@latest
			return
		fi
	fi
}

install_fd() {
	if command -v brew >/dev/null; then
		brew install fd
		return
	fi
	# we have apt, use it
	if ! sudo apt-get update --yes && sudo apt-get install --yes --no-install-recommends fd-find; then
		export FD_BIN="fdfind"
	fi
}
