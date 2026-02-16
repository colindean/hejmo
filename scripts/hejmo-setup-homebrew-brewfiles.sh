#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_DIR}/_hejmo_stdlib_helpers.sh"

bb_install(){
  local brewfile="${1}"
  log_info "Installing from ${brewfile}…"
  brew bundle install --file="${brewfile}" --verbose
}

bb_install "${HEJMO}/Brewfile.all"

# Map uname output to Brewfile naming convention
declare OS OS_NAME
OS="$(uname -s)"
case "${OS}" in
  Darwin)
    OS_NAME="macos"
    ;;
  Linux)
    OS_NAME="linux"
    ;;
  *)
    log_warning "Unsupported OS: ${OS}. Using raw OS name for Brewfile lookup."
    OS_NAME="${OS}"
    ;;
esac

OS_BREWFILE="${HEJMO}/Brewfile.${OS_NAME}"

if [[ -f "${OS_BREWFILE}" ]]; then
  bb_install "${OS_BREWFILE}"
else
  log_warning "No Brewfile for ${OS_NAME}. Create one in ${OS_BREWFILE}."
fi

HOST="${INTENDED_HOSTNAME:-$(hostname)}"
HOST_BREWFILE="${HEJMO}/Brewfile.${HOST}"

if [[ -f "${HOST_BREWFILE}" ]]; then
  bb_install "${HOST_BREWFILE}"
else
  log_warning "No Brewfile for ${HOST}. Create one in ${HOST_BREWFILE} or set INTENDED_HOSTNAME."
fi
