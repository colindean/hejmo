#!/usr/bin/env sh

if command -v rsvg-convert >/dev/null; then
	alias svg2png="rsvg-convert"
fi
