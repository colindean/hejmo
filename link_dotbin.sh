#!/bin/bash
RM=$1
NO_PREPEND=""
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${SCRIPT_DIR}/_helpers.sh"

BIN_SCRIPTS_DIR="$SCRIPT_DIR/scripts"
DOTBIN_DIR="$HOME/.bin"

if [[ ! -d "$BIN_SCRIPTS_DIR" ]]; then
  echo "The Hejmo scripts directory does not appear to be present at $BIN_SCRIPTS_DIR"
  echo "Please check for its existence."
  exit 1
fi

mkdir -p "$DOTBIN_DIR"

if [[ ! -d "$DOTBIN_DIR" ]]; then
  echo "$DOTBIN_DIR directory does not appear to be present."
  echo "Please check for its existence, maybe manually create it."
  exit 1
fi

link_all_files_in_dir "${BIN_SCRIPTS_DIR}" "${DOTBIN_DIR}" "${RM}" "${NO_PREPEND}"
