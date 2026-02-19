#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_DIR}/_hejmo_stdlib_helpers.sh"

# Detect the Linux distribution
detect_distribution() {
  if [[ -f /etc/os-release ]]; then
    # shellcheck source=/dev/null
    . /etc/os-release
    if [[ -z "${ID}" ]]; then
      echo "unknown"
    else
      echo "${ID}"
    fi
  else
    echo "unknown"
  fi
}

# Install prerequisites for Debian/Ubuntu
install_debian_prerequisites() {
  log_info "Installing Homebrew prerequisites for Debian/Ubuntu…"
  if ! sudo apt-get update; then
    log_failure "Failed to update apt package lists"
    exit 1
  fi
  if ! sudo apt-get install -y build-essential procps curl file git; then
    log_failure "Failed to install Homebrew prerequisites"
    exit 1
  fi
}

# Install prerequisites for Fedora
install_fedora_prerequisites() {
  log_info "Installing Homebrew prerequisites for Fedora…"
  if ! sudo dnf groupinstall -y 'Development Tools' 2>/dev/null && ! sudo dnf group install -y development-tools; then
    log_failure "Failed to install development tools group (tried both 'Development Tools' and 'development-tools')"
    exit 1
  fi
  if ! sudo dnf install -y procps-ng curl file git; then
    log_failure "Failed to install Homebrew prerequisites"
    exit 1
  fi
}

# Install prerequisites for CentOS/RHEL
install_centos_prerequisites() {
  log_info "Installing Homebrew prerequisites for CentOS/RHEL…"
  # Check if dnf is available, otherwise fall back to yum
  local pkg_manager
  if command_exists "dnf"; then
    pkg_manager="dnf"
  elif command_exists "yum"; then
    pkg_manager="yum"
  else
    log_failure "Neither dnf nor yum package manager found"
    exit 1
  fi
  
  if ! sudo "${pkg_manager}" groupinstall -y 'Development Tools'; then
    log_failure "Failed to install Development Tools group"
    exit 1
  fi
  if ! sudo "${pkg_manager}" install -y procps-ng curl file git; then
    log_failure "Failed to install Homebrew prerequisites"
    exit 1
  fi
}

# Install prerequisites for Arch Linux
install_arch_prerequisites() {
  log_info "Installing Homebrew prerequisites for Arch Linux…"
  if ! sudo pacman -S --noconfirm --needed base-devel procps-ng curl file git; then
    log_failure "Failed to install Homebrew prerequisites"
    exit 1
  fi
}

# Install prerequisites based on the detected distribution
install_prerequisites() {
  local distro
  distro=$(detect_distribution)

  log_info "Detected distribution: ${distro}"

  case "${distro}" in
    ubuntu|debian|pop)
      install_debian_prerequisites
      ;;
    fedora)
      install_fedora_prerequisites
      ;;
    centos|rhel|rocky|almalinux)
      install_centos_prerequisites
      ;;
    arch|manjaro)
      install_arch_prerequisites
      ;;
    *)
      log_warning "Unknown distribution: ${distro}. Skipping prerequisite installation."
      log_warning "Please ensure you have curl, git, and build tools installed."
      # Verify critical dependencies
      if ! command_exists "curl"; then
        log_failure "curl is not installed. Please install it manually."
        exit 1
      fi
      if ! command_exists "git"; then
        log_failure "git is not installed. Please install it manually."
        exit 1
      fi
      ;;
  esac
}

install_homebrew() {
  local homebrew_installer_url="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

  # Detect OS type
  case "${OS_TYPE}" in
    Darwin)
      log_info "macOS detected. No prerequisites needed."
      ;;
    Linux)
      log_info "Linux detected. Installing prerequisites…"
      install_prerequisites
      ;;
    *)
      log_warning "Unknown operating system. Attempting to install anyway…"
      ;;
  esac

  cache_path="$(mktemp -d)"
  cached_installer="${cache_path}/install_homebrew.sh"
  log_info "Downloading Homebrew installer to ${cached_installer}…"

  log_debug "Homebrew installer URL: [${homebrew_installer_url}]"
  curl -fsSL "${homebrew_installer_url}" > "${cached_installer}"

  log_info "Running Homebrew installer…"
  bash "${cached_installer}"
}

if ! command_exists "brew"; then
  log_warning "brew isn't available, installing Homebrew."
  install_homebrew
fi
