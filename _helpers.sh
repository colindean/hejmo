#!/usr/bin/env bash

command_exists() {
  local cmd="$1"
  command -v "${cmd}" >/dev/null 2>&1
}

install_homebrew() {
  local homebrew_installer_url="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

  if ! command_exists "curl"; then
    log_warning "curl is not installed. Attempting to install curl with apt…"
    if command_exists "apt"; then
        sudo apt install curl
    else
      log_failure "apt & curl aren't available. What's up?"
      exit 2
    fi
  fi

  cache_path="$(mktemp -d)"
  cached_installer="${cache_path}/install_homebrew.sh"

  log_info "Downloading Homebrew installer to ${cached_installer}…"
  log_debug "Homebrew installer URL: [${homebrew_installer_url}]"
  curl -fsSL "${homebrew_installer_url}" > "${cached_installer}"

  log_info "Running Homebrew installer…"
  bash -c "${cached_installer}"
}

install_packages() {
  local listfile="$1"
  local cmd_template="$2"

  failed=()
  while read -r package; do
    # Skip empty lines
    [[ -z "$package" ]] && continue
    local clean_package;
    clean_package=$(echo "${package}" | sed -e 's/\//\\\//g')
    local cmd;
    cmd="${cmd_template//\%PACKAGE\%/${clean_package}}"
    if ! eval "${cmd}"; then
      failed+=("${package}")
    fi
  done < "${listfile}"
  if [[ ${#failed[@]} -gt 0 ]]; then
    echo "These packages failed to install:"
    printf "\t%s\n" "${failed[@]}"
    echo "You can to rerun this script until this message disappears."
    echo "Inspect the transcript to find more exact errors."
  fi
}

# from_dir must be an absolute path!
link_all_files_in_dir() {
  from_dir="$1"
  to_dir="$2"
  rm="$3"
  prepend="$4"

  case "$(uname -s)" in
    Darwin) LN_OPTIONS="sFf" ;;
    Linux) LN_OPTIONS="sf" ;;
    # TODO: determine safe defaults for OSes I never use
    *) LN_OPTIONS="sf" ;;
  esac

  # TODO: SC2045: Use a loop with globbing instead of ls
  for f in $(ls "${from_dir}"); do
    TARGET="${from_dir}/${f}"
    LINK="${to_dir}/${prepend}${f}"
    if [[ -n ${rm} ]]; then
      echo "Removing ${LINK}"
      rm -f "${LINK}"
    fi
    echo "Linking ${LINK} to ${TARGET}"
    ln "${LN_OPTIONS}" "${TARGET}" "${LINK}"
  done
}

banner_text() {
  local text="${*}"
  printf "\033#3%s\n" "${text}"
  printf "\033#4%s\n" "${text}"
  printf "\033#5"
}

CHECKMARK="\u2713"
CROSSMARK="\u2717"
EXCLAMATION="\u26A0"
INFOMARK="\u2139"
INTERROBANG="\u203D"

BLUE_COLOR="\033[0;34m"
RED_COLOR="\033[0;31m"
YELLOW_COLOR="\033[0;33m"
GRAY_COLOR="\033[0;37m"
RESET_COLOR="\033[0m"
BOLD_COLOR="\033[1m"

SUCCESS_COLOR="${BLUE_COLOR}"
FAILURE_COLOR="${RED_COLOR}"
   INFO_COLOR="${BLUE_COLOR}"
WARNING_COLOR="${YELLOW_COLOR}"
  DEBUG_COLOR="${GRAY_COLOR}"

SUCCESS_TEXT="${SUCCESS_COLOR}${BOLD_COLOR}[${CHECKMARK} SUCC]${RESET_COLOR}"
FAILURE_TEXT="${FAILURE_COLOR}[${CROSSMARK} FAIL]${RESET_COLOR}"
   INFO_TEXT="${INFO_COLOR}[${INFOMARK} INFO]${RESET_COLOR}"
WARNING_TEXT="${WARNING_COLOR}[${EXCLAMATION} WARN]${RESET_COLOR}"
  DEBUG_TEXT="${DEBUG_COLOR}[${INTERROBANG} DBUG]${RESET_COLOR}"

stderr_log() {
  echo -e "${*}" >&2
}

log_success() {
  stderr_log "${SUCCESS_TEXT} ${BOLD_COLOR}${*}${RESET_COLOR}"
}
log_failure() {
  stderr_log  "${FAILURE_TEXT} ${*}"
}
log_info() {
  stderr_log "${INFO_TEXT} ${*}"
}
log_warning() {
  stderr_log "${WARNING_TEXT} ${*}"
}
log_debug() {
  if [[ -n "${DEBUG}" ]]; then
    stderr_log "${DEBUG_TEXT} ${*}"
  fi
}

test_hejmo_logs() {
  log_success "This is a success message."
  log_failure "This is a failure message."
  log_info    "This is an info message."
  log_warning "This is a warning message."
  DEBUG=1 \
  log_debug   "This is a debug message."
  banner_text "This is a banner text."
}