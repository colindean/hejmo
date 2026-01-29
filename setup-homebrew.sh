#!/bin/sh
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_DIR}/_helpers.sh"

if ! command_exists "brew"; then
  log_warning "brew isn't available, installing Homebrew."
  install_homebrew
fi
