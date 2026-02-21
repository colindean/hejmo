#!/bin/sh
echo "Setting up the shell to use bash from Homebrew…"

# shellcheck disable=SC2312
echo "Current shell is ${SHELL} ($(${SHELL} --version | head -n 1))"

BREW_DIR=$(brew --prefix bash)
BASH="${BREW_DIR}/bin/bash"

if [ ! -x "${BASH}" ]; then
	echo "Need to install bash, so doing that now…"
	brew install bash
fi

if [ ! -x "${BASH}" ]; then
	echo "Homebrew bash in ${BASH} not found even after (re)installing it, do something about it."
	exit 1
fi

echo "Adding ${BASH} to shells as superuser…"
echo "${BASH}" | sudo tee -a /etc/shells >/dev/null

# shellcheck disable=SC2312
echo "Setting ${BASH} as shell for $(whoami)…"
chsh -s "${BASH}"

echo "Now, reopen the terminal or try 'rebash' to reload using the newer bash."
# shellcheck disable=SC2312
echo "New shell will be ${BASH} ($(${BASH} --version | head -n 1))."
echo "Happy bashing!"
