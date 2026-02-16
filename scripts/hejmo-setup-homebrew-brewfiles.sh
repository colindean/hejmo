#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_DIR}/_hejmo_stdlib_helpers.sh"

# Check if brew is available before proceeding
if ! command_exists brew; then
  log_failure "Homebrew (brew) is not installed or not in PATH. Please install Homebrew first."
  exit 1
fi

bb_install(){
  local brewfile="${1}"
  log_info "Installing from ${brewfile}…"
  if ! brew bundle install --file="${brewfile}" --verbose; then
    log_failure "Failed to install packages from ${brewfile}"
  fi
}

bb_install "${HEJMO}/Brewfile.all"

declare OS
OS="$(uname -s)"
OS_BREWFILE="${HEJMO}/Brewfile.${OS}"

if [[ -f "${OS_BREWFILE}" ]]; then
  bb_install "${OS_BREWFILE}"
else
  log_warning "No Brewfile for ${OS}. Create one in ${OS_BREWFILE}."
fi

HOST="${INTENDED_HOSTNAME:-$(hostname)}"
HOST_BREWFILE="${HEJMO}/Brewfile.${HOST}"

if [[ -f "${HOST_BREWFILE}" ]]; then
  bb_install "${HOST_BREWFILE}"
else
  log_warning "No Brewfile for ${HOST}. Create one in ${HOST_BREWFILE} or set INTENDED_HOSTNAME."
fi
