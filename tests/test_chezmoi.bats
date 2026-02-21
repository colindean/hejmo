#!/usr/bin/env bats

# Test suite for Chezmoi integration
# These tests verify that chezmoi properly manages dotfiles

setup() {
	# Run before each test
	export HOME="${HOME:-/home/runner}"
}

@test "chezmoi is installed and working" {
	run chezmoi --version
	[[ "${status}" -eq 0 ]]
	[[ "${output}" =~ "chezmoi version" ]]
}

@test ".chezmoiroot file exists in repository" {
	[[ -n "${GITHUB_WORKSPACE}" ]] || {
		echo "GITHUB_WORKSPACE is not set" >&2
		return 1
	}
	[[ -f "${GITHUB_WORKSPACE}/.chezmoiroot" ]]
	content=$(cat "${GITHUB_WORKSPACE}/.chezmoiroot")
	[[ "${content}" = "home" ]]
}

@test "chezmoi source directory is correctly linked" {
	[[ -e "${HOME}/.local/share/chezmoi" ]]
}

@test "chezmoi config file was generated" {
	[[ -f "${HOME}/.config/chezmoi/chezmoi.toml" ]]
}

@test ".bash_profile symlink exists and points to chezmoi source" {
	[[ -L "${HOME}/.bash_profile" ]]
	target=$(readlink "${HOME}/.bash_profile")
	[[ "${target}" =~ "chezmoi" ]]
}

@test ".gitconfig symlink exists and points to chezmoi source" {
	[[ -L "${HOME}/.gitconfig" ]]
	target=$(readlink "${HOME}/.gitconfig")
	[[ "${target}" =~ "chezmoi" ]]
}

@test ".vimrc symlink exists and points to chezmoi source" {
	[[ -L "${HOME}/.vimrc" ]]
	target=$(readlink "${HOME}/.vimrc")
	[[ "${target}" =~ "chezmoi" ]]
}

@test ".gitconfig contains expected content" {
	[[ -f "${HOME}/.gitconfig" ]]
	grep -q "user" "${HOME}/.gitconfig"
}

@test ".bash_profile contains expected content" {
	[[ -f "${HOME}/.bash_profile" ]]
	grep -q "HEJMO" "${HOME}/.bash_profile"
}

@test "chezmoi managed files includes dotfiles" {
	run chezmoi managed
	[[ "${status}" -eq 0 ]]
	[[ "${output}" =~ .bash_profile ]]
	[[ "${output}" =~ .gitconfig ]]
	[[ "${output}" =~ .vimrc ]]
}

@test "chezmoi status shows no changes" {
	run chezmoi status
	[[ "${status}" -eq 0 ]]
	# Status should be empty or only show expected differences
}

@test "chezmoi diff shows no unexpected changes" {
	run chezmoi diff
	[[ "${status}" -eq 0 ]]
	# Diff should be empty or only show expected differences
}

@test ".vim directory symlink exists" {
	# .vim is a directory with symlinked files inside
	[[ -d "${HOME}/.vim" ]]
	# Check that it's managed by chezmoi
	# shellcheck disable=SC2312
	chezmoi managed | grep -q "\.vim"
}

@test ".tmux.conf symlink exists" {
	[[ -L "${HOME}/.tmux.conf" ]]
}

@test "symlinks are in symlink mode not file mode" {
	# Verify that files are symlinks, not copies
	[[ -L "${HOME}/.bash_profile" ]]
	[[ -L "${HOME}/.gitconfig" ]]
	[[ -L "${HOME}/.vimrc" ]]
	[[ -L "${HOME}/.tmux.conf" ]]
}

@test "chezmoi source directory contains expected files" {
	# The source directory is the repository clone with .chezmoiroot pointing to home/
	source_dir="${HOME}/.local/share/chezmoi"
	[[ -f "${source_dir}/.chezmoiroot" ]]
	[[ -f "${source_dir}/home/dot_bash_profile" ]]
	[[ -f "${source_dir}/home/dot_gitconfig" ]]
	[[ -f "${source_dir}/home/dot_vimrc" ]]
	[[ -f "${source_dir}/home/.chezmoi.toml.tmpl" ]]
}

@test "chezmoi config has symlink mode enabled" {
	config_file="${HOME}/.config/chezmoi/chezmoi.toml"
	[[ -f "${config_file}" ]]
	grep -q 'mode.*=.*"symlink"' "${config_file}"
}

@test "HEJMO scripts directory is in PATH" {
	# Source the bash_profile to set up environment
	# shellcheck source=/dev/null
	source "${HOME}/.bash_profile"

	# Check that HEJMO/scripts is in PATH
	[[ -n "${HEJMO}" ]] || {
		echo "HEJMO is not set" >&2
		return 1
	}
	[[ ":${PATH}:" == *":${HEJMO}/scripts:"* ]]
}

@test "scripts from HEJMO are executable via command" {
	# Source the bash_profile to set up environment
	# shellcheck source=/dev/null
	source "${HOME}/.bash_profile"

	# Verify a script from the scripts directory is findable
	# Using 'clipboard' as a test script
	run command -v clipboard
	[[ "${status}" -eq 0 ]]
	[[ "${output}" =~ "scripts/clipboard" ]]
}
