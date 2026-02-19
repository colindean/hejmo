#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# shellcheck source=scripts/_hejmo_stdlib_helpers.sh
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

if [[ -z "${HEJMO}" ]]; then
	echo >&2 "ERROR: HEJMO is not set"
	exit 1
fi
bb_install "${HEJMO}/Brewfile.all"

# Map uname output to Brewfile naming convention
declare -A OS_MAP=( [Darwin]=macos [Linux]=linux )
declare OS OS_NAME
if [[ -z "${OS_TYPE}" ]]; then
	echo >&2 "ERROR: OS_TYPE is not set (should be set by _hejmo_stdlib_helpers.sh)"
	exit 1
fi
OS="${OS_TYPE}"
OS_NAME="${OS_MAP[${OS}]}"

if [[ -z "${OS_NAME}" ]]; then
  log_warning "Unrecognized OS: ${OS}. Using raw OS name for Brewfile lookup."
  OS_NAME="${OS}"
fi

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
