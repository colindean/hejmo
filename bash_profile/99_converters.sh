#!/usr/bin/env sh

if [ -n "$(command -v rsvg-convert)" ]; then
  alias svg2png="rsvg-convert"
fi
