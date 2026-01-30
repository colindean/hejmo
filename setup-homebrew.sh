#!/bin/sh
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_DIR}/_helpers.sh"

ensure_apt_package() {
  local package_name="$1"
  if ! command_exists "apt"; then
    log_failure "apt isn't available. What's up?"
  fi
  if ! dpkg -s "${package_name}" >/dev/null 2>&1; then
    log_info "Installing required package: ${package_name}…"
    sudo apt update
    sudo apt install -y "${package_name}"
  else
    log_debug "Package ${package_name} is already installed."
  fi
}

install_homebrew() {
  local homebrew_installer_url="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

  log_info "Ensuring required dependencies git and curl are installed…"
  command_exists "git" || ensure_apt_package "git"
  command_exists "curl" || ensure_apt_package "curl"

  cache_path="$(mktemp -d)"
  cached_installer="${cache_path}/install_homebrew.sh"
  log_info "Downloading Homebrew installer to ${cached_installer}…"

  log_info "Homebrew installer URL: [${homebrew_installer_url}]"
  curl -fsSL "${homebrew_installer_url}" > "${cached_installer}"

  log_info "Running Homebrew installer…"
  bash "${cached_installer}"
}

if ! command_exists "brew"; then
  log_warning "brew isn't available, installing Homebrew."
  install_homebrew
fi
