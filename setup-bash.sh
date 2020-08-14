#!/bin/sh

brew install bash
BREW_DIR=`brew --prefix`
BASH="$BREW_DIR/bin/bash"
echo "Adding $BASH to shells…"
echo "$BASH" | sudo tee -a /etc/shells
echo "Setting $BASH as shell…"
chsh -s "$BASH"
