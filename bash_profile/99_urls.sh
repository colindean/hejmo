#!/usr/bin/env bash

shellcheck_wiki() {
	local ARTICLE="${1}"
	local BASE_URL="https://github.com/koalaman/shellcheck/wiki"
	local GO_URL="${BASE_URL}/${ARTICLE}"
	if command -v xdg-open > /dev/null; then
		xdg-open "${GO_URL}"
	else
		open "${GO_URL}"
	fi
}

alias scw="shellcheck_wiki"

function wttr() {
	curl "https://wttr.in/${*}"
}

function urlencode() {
	# @uri for "applies percent-encoding, by mapping all reserved URI characters to a %XX sequence."
	jq --slurp --raw-input --raw-output @uri
}

function urldecode() {
	perl -pe 's/\%(\w\w)/chr hex $1/ge'
}

alias qr="qrencode -t ANSI256UTF8"
