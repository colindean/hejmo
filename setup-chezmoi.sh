#!/usr/bin/env bash
#
# Setup chezmoi for dotfile management
#
# This script installs chezmoi if not already installed,
# then initializes it with the hejmo repository using symlink mode.
#
# Usage:
#   bash setup-chezmoi.sh [--apply]
#
# Options:
#   --apply    Apply the changes immediately (create symlinks)
#

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

log_info() {
  echo ">>> $*"
}

log_success() {
  echo "✓ $*"
}

log_error() {
  echo "ERROR: $*" >&2
}

# Check if chezmoi is installed
if ! command -v chezmoi &> /dev/null; then
  log_info "Installing chezmoi..."
  
  case "$(uname -s)" in
    Darwin)
      # On macOS, use Homebrew if available
      if command -v brew &> /dev/null; then
        brew install chezmoi
      else
        # Fallback to shell script installer
        sh -c "$(curl -fsLS https://get.chezmoi.io)" -- -b "${HOME}/.local/bin"
      fi
      ;;
    Linux)
      # Try package managers first
      if command -v apt-get &> /dev/null; then
        # Note: chezmoi may not be in standard repos
        # Fallback to shell script installer
        sh -c "$(curl -fsLS https://get.chezmoi.io)" -- -b "${HOME}/.local/bin"
      elif command -v snap &> /dev/null; then
        sudo snap install chezmoi --classic
      else
        # Fallback to shell script installer
        sh -c "$(curl -fsLS https://get.chezmoi.io)" -- -b "${HOME}/.local/bin"
      fi
      ;;
    *)
      log_error "Unsupported operating system: $(uname -s)"
      log_info "Please install chezmoi manually from: https://www.chezmoi.io/install/"
      exit 1
      ;;
  esac
  
  # Add ~/.local/bin to PATH if not already there
  if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
  fi
  
  log_success "chezmoi installed"
else
  log_success "chezmoi is already installed"
fi

# Verify chezmoi is now available
if ! command -v chezmoi &> /dev/null; then
  log_error "chezmoi installation failed or not in PATH"
  exit 1
fi

log_info "chezmoi version: $(chezmoi --version)"

# Initialize chezmoi with the hejmo repository
log_info "Initializing chezmoi with hejmo..."

# Set the source directory to be within the hejmo repository
# This allows the repository itself to be the chezmoi source
CHEZMOI_SOURCE_DIR="${SCRIPT_DIR}/home"

# Check if already initialized
if [ -d "${HOME}/.local/share/chezmoi" ] || [ -L "${HOME}/.local/share/chezmoi" ]; then
  log_info "Chezmoi already initialized at ~/.local/share/chezmoi"
  log_info "To reinitialize, remove ~/.local/share/chezmoi first"
else
  # Create symlink to the home directory in the repo
  mkdir -p "${HOME}/.local/share"
  ln -s "${CHEZMOI_SOURCE_DIR}" "${HOME}/.local/share/chezmoi"
  log_success "Linked ${CHEZMOI_SOURCE_DIR} to ~/.local/share/chezmoi"
fi

# Apply changes if requested
if [[ "$1" == "--apply" ]]; then
  log_info "Applying chezmoi configuration with symlink mode..."
  chezmoi apply --mode symlink --verbose
  log_success "Chezmoi configuration applied"
else
  log_info "To apply the configuration (create symlinks), run:"
  log_info "  chezmoi apply --mode symlink"
  log_info ""
  log_info "To see what would be changed without applying:"
  log_info "  chezmoi diff --mode symlink"
fi

log_success "Chezmoi setup complete!"
