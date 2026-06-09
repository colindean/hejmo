#!/usr/bin/env bats
# shellcheck disable=SC1091,SC2154,SC2030,SC2031,SC2329,SC2317
bats_require_minimum_version 1.5.0

# Test suite for editorconfig-changes
# These tests verify the editorconfig-changes script functions

setup() {
	export DEBUG=""

	# Source the script so individual functions are testable
	source "${BATS_TEST_DIRNAME}/../scripts/editorconfig-changes"

	# Mock the editorconfig CLI so tests run without the real binary.
	# Tests set MOCK_EDITORCONFIG_OUTPUT to control what is returned.
	editorconfig() {
		printf '%s\n' "${MOCK_EDITORCONFIG_OUTPUT:-}"
	}
	export -f editorconfig

	# Temporary directory for test files
	TEST_DIR="${BATS_TEST_TMPDIR}/test_files"
	mkdir -p "${TEST_DIR}"
}

teardown() {
	rm -rf "${BATS_TEST_TMPDIR}/test_files"
}

# ---------------------------------------------------------------------------
# Helper: write content to a named file and echo its absolute path
# ---------------------------------------------------------------------------
create_test_file() {
	local filename="$1"
	local content="$2"
	printf '%s' "${content}" > "${TEST_DIR}/${filename}"
	printf '%s' "${TEST_DIR}/${filename}"
}

# ---------------------------------------------------------------------------
# Basic sanity checks
# ---------------------------------------------------------------------------

@test "script is executable" {
	[[ -x "${BATS_TEST_DIRNAME}/../scripts/editorconfig-changes" ]]
}

@test "script can be sourced without errors" {
	run bash -c "source ${BATS_TEST_DIRNAME}/../scripts/editorconfig-changes; echo 'sourced'"
	[[ "${status}" -eq 0 ]]
	[[ "${output}" =~ "sourced" ]]
}

@test "main exits 1 when no arguments are given" {
	run main
	[[ "${status}" -eq 1 ]]
}

# ---------------------------------------------------------------------------
# strip_quotes
# ---------------------------------------------------------------------------

@test "strip_quotes removes double quotes" {
	run strip_quotes '"utf-8"'
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "utf-8" ]]
}

@test "strip_quotes removes single quotes" {
	# shellcheck disable=SC2016
	run strip_quotes "'utf-8'"
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "utf-8" ]]
}

@test "strip_quotes leaves unquoted values unchanged" {
	run strip_quotes "utf-8"
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "utf-8" ]]
}

# ---------------------------------------------------------------------------
# is_binary_file
# ---------------------------------------------------------------------------

@test "is_binary_file returns true for binary files" {
	local binary_file="${TEST_DIR}/binary.bin"
	printf '\x00\x01\x02\x03' > "${binary_file}"

	# Mock file command to report binary encoding
	file() { echo "binary"; }
	export -f file

	run is_binary_file "${binary_file}"
	[[ "${status}" -eq 0 ]]
}

@test "is_binary_file returns false for text files" {
	local text_file
	text_file=$(create_test_file "text.txt" "hello world")

	# Mock file command to report text encoding
	file() { echo "us-ascii"; }
	export -f file

	run is_binary_file "${text_file}"
	[[ "${status}" -ne 0 ]]
}

# ---------------------------------------------------------------------------
# apply_trim_trailing_whitespace
# ---------------------------------------------------------------------------

@test "apply_trim_trailing_whitespace removes trailing spaces" {
	local test_file
	test_file=$(create_test_file "spaces.txt" "$(printf 'hello   \nworld\n')")

	apply_trim_trailing_whitespace "${test_file}"

	run cat "${test_file}"
	[[ "${output}" == "$(printf 'hello\nworld')" ]]
}

@test "apply_trim_trailing_whitespace removes trailing tabs" {
	local test_file
	test_file=$(create_test_file "tabs.txt" "$(printf 'hello\t\t\nworld\n')")

	apply_trim_trailing_whitespace "${test_file}"

	run cat "${test_file}"
	[[ "${output}" == "$(printf 'hello\nworld')" ]]
}

@test "apply_trim_trailing_whitespace leaves clean lines unchanged" {
	local test_file
	test_file=$(create_test_file "clean.txt" "$(printf 'hello\nworld\n')")

	apply_trim_trailing_whitespace "${test_file}"

	run cat "${test_file}"
	[[ "${output}" == "$(printf 'hello\nworld')" ]]
}

# ---------------------------------------------------------------------------
# apply_end_of_line
# ---------------------------------------------------------------------------

@test "apply_end_of_line converts CRLF to LF" {
	local test_file
	test_file=$(create_test_file "crlf.txt" "$(printf 'line1\r\nline2\r\n')")

	apply_end_of_line "${test_file}" "lf"

	# No CR bytes should remain
	local hex_content
	hex_content=$(od -An -tx1 "${test_file}" | tr -d ' \n')
	[[ "${hex_content}" != *"0d"* ]]
}

@test "apply_end_of_line converts LF to CRLF" {
	local test_file
	test_file=$(create_test_file "lf.txt" "$(printf 'line1\nline2\n')")

	apply_end_of_line "${test_file}" "crlf"

	# CR bytes (0d) should be present
	local hex_content
	hex_content=$(od -An -tx1 "${test_file}" | tr -d ' \n')
	[[ "${hex_content}" == *"0d"* ]]
}

@test "apply_end_of_line is idempotent for LF files with lf setting" {
	local test_file
	test_file=$(create_test_file "lf_already.txt" "$(printf 'line1\nline2\n')")
	local before
	before=$(cat "${test_file}")

	apply_end_of_line "${test_file}" "lf"

	run cat "${test_file}"
	[[ "${output}" == "${before}" ]]
}

# ---------------------------------------------------------------------------
# apply_insert_final_newline
# ---------------------------------------------------------------------------

@test "apply_insert_final_newline adds newline when missing and value is true" {
	local test_file
	test_file=$(create_test_file "no_eol.txt" "$(printf 'hello')")

	apply_insert_final_newline "${test_file}" "true"

	local last_byte
	last_byte=$(tail -c 1 "${test_file}" | od -An -tx1 | tr -d ' \n')
	[[ "${last_byte}" == "0a" ]]
}

@test "apply_insert_final_newline does not add duplicate newline" {
	local test_file
	test_file=$(create_test_file "has_eol.txt" "$(printf 'hello\n')")

	apply_insert_final_newline "${test_file}" "true"

	# File should be exactly 6 bytes: h e l l o \n
	local size
	size=$(wc -c < "${test_file}" | tr -d ' ')
	[[ "${size}" -eq 6 ]]
}

@test "apply_insert_final_newline removes trailing newline when value is false" {
	local test_file
	test_file=$(create_test_file "has_eol2.txt" "$(printf 'hello\n')")

	apply_insert_final_newline "${test_file}" "false"

	local last_byte
	last_byte=$(tail -c 1 "${test_file}" | od -An -tx1 | tr -d ' \n')
	[[ "${last_byte}" != "0a" ]]
}

@test "apply_insert_final_newline does nothing to empty file" {
	local test_file
	test_file=$(create_test_file "empty.txt" "")

	apply_insert_final_newline "${test_file}" "true"

	# File should remain empty
	local size
	size=$(wc -c < "${test_file}" | tr -d ' ')
	[[ "${size}" -eq 0 ]]
}

# ---------------------------------------------------------------------------
# process_file
# ---------------------------------------------------------------------------

@test "process_file returns 0 for a file that already conforms" {
	local test_file="${TEST_DIR}/good.txt"
	printf 'hello\nworld\n' > "${test_file}"
	export MOCK_EDITORCONFIG_OUTPUT="end_of_line=lf
insert_final_newline=true
trim_trailing_whitespace=true"

	run process_file "${test_file}"
	[[ "${status}" -eq 0 ]]
	[[ -z "${output}" ]]
}

@test "process_file returns 1 and outputs diff for trailing whitespace" {
	local test_file
	test_file=$(create_test_file "trailing.txt" "$(printf 'hello   \nworld\n')")
	export MOCK_EDITORCONFIG_OUTPUT="trim_trailing_whitespace=true"

	run process_file "${test_file}"
	[[ "${status}" -eq 1 ]]
	[[ "${output}" =~ "hello" ]]
}

@test "process_file returns 1 and outputs diff for missing final newline" {
	local test_file
	test_file=$(create_test_file "noeol.txt" "$(printf 'line1\nline2')")
	export MOCK_EDITORCONFIG_OUTPUT="insert_final_newline=true"

	run process_file "${test_file}"
	[[ "${status}" -eq 1 ]]
	[[ "${output}" =~ "line2" ]]
}

@test "process_file returns 1 and outputs diff for extra final newline" {
	local test_file="${TEST_DIR}/extranl.txt"
	printf 'line1\nline2\n' > "${test_file}"
	export MOCK_EDITORCONFIG_OUTPUT="insert_final_newline=false"

	run process_file "${test_file}"
	[[ "${status}" -eq 1 ]]
}

@test "process_file returns 1 and outputs diff for CRLF when LF expected" {
	local test_file
	test_file=$(create_test_file "crlf.txt" "$(printf 'line1\r\nline2\r\n')")
	export MOCK_EDITORCONFIG_OUTPUT="end_of_line=lf"

	run process_file "${test_file}"
	[[ "${status}" -eq 1 ]]
}

@test "process_file returns 0 for a file with no editorconfig settings" {
	local test_file
	test_file=$(create_test_file "no_cfg.txt" "hello")
	export MOCK_EDITORCONFIG_OUTPUT=""

	run process_file "${test_file}"
	[[ "${status}" -eq 0 ]]
}

@test "process_file returns 0 for a non-existent path" {
	run process_file "/nonexistent/path/to/file.txt"
	[[ "${status}" -eq 0 ]]
}

@test "process_file skips binary files" {
	local binary_file="${TEST_DIR}/binary.bin"
	printf '\x00\x01\x02\x03' > "${binary_file}"
	export MOCK_EDITORCONFIG_OUTPUT="trim_trailing_whitespace=true"

	# Mock file to report binary
	file() { echo "binary"; }
	export -f file

	run process_file "${binary_file}"
	[[ "${status}" -eq 0 ]]
	[[ -z "${output}" ]]
}

@test "process_file diff output uses the original file path, not a temp path" {
	local test_file
	test_file=$(create_test_file "orig.txt" "$(printf 'hello   \n')")
	export MOCK_EDITORCONFIG_OUTPUT="trim_trailing_whitespace=true"

	run process_file "${test_file}"
	[[ "${status}" -eq 1 ]]
	# The diff output should reference the original file, not /tmp/...
	[[ "${output}" == *"${test_file}"* ]]
	[[ "${output}" != *"/tmp/tmp."* ]]
}

@test "process_file handles quoted values in editorconfig output" {
	local test_file
	test_file=$(create_test_file "quoted.txt" "$(printf 'hello   \n')")
	export MOCK_EDITORCONFIG_OUTPUT='trim_trailing_whitespace="true"'

	run process_file "${test_file}"
	[[ "${status}" -eq 1 ]]
}

# ---------------------------------------------------------------------------
# main
# ---------------------------------------------------------------------------

@test "main exits 0 when all files already conform" {
	local test_file="${TEST_DIR}/clean.txt"
	printf 'hello\n' > "${test_file}"
	export MOCK_EDITORCONFIG_OUTPUT="insert_final_newline=true
trim_trailing_whitespace=true"

	run main "${test_file}"
	[[ "${status}" -eq 0 ]]
	[[ -z "${output}" ]]
}

@test "main exits 1 and emits a patch when a file needs changes" {
	local test_file
	test_file=$(create_test_file "dirty.txt" "$(printf 'hello   \n')")
	export MOCK_EDITORCONFIG_OUTPUT="trim_trailing_whitespace=true"

	run main "${test_file}"
	[[ "${status}" -eq 1 ]]
	[[ "${output}" =~ "hello" ]]
}

@test "main processes multiple file arguments" {
	local clean_file dirty_file
	clean_file=$(create_test_file "clean2.txt" "$(printf 'ok\n')")
	dirty_file=$(create_test_file "dirty2.txt" "$(printf 'bad   \n')")
	export MOCK_EDITORCONFIG_OUTPUT="trim_trailing_whitespace=true"

	run main "${clean_file}" "${dirty_file}"
	[[ "${status}" -eq 1 ]]
	[[ "${output}" =~ "bad" ]]
}

@test "main reads file paths from stdin when - is passed" {
	local test_file
	test_file=$(create_test_file "stdin.txt" "$(printf 'hi   \n')")
	export MOCK_EDITORCONFIG_OUTPUT="trim_trailing_whitespace=true"

	run bash -c "
		source '${BATS_TEST_DIRNAME}/../scripts/editorconfig-changes'
		editorconfig() { printf '%s\n' \"\${MOCK_EDITORCONFIG_OUTPUT:-}\"; }
		export -f editorconfig
		export MOCK_EDITORCONFIG_OUTPUT='trim_trailing_whitespace=true'
		printf '%s\n' '${test_file}' | main -
	"
	[[ "${status}" -eq 1 ]]
	[[ "${output}" =~ "hi" ]]
}

@test "main ignores blank lines when reading from stdin" {
	local test_file="${TEST_DIR}/blank_stdin.txt"
	printf 'ok\n' > "${test_file}"
	export MOCK_EDITORCONFIG_OUTPUT="insert_final_newline=true"

	run bash -c "
		source '${BATS_TEST_DIRNAME}/../scripts/editorconfig-changes'
		editorconfig() { printf '%s\n' \"\${MOCK_EDITORCONFIG_OUTPUT:-}\"; }
		export -f editorconfig
		export MOCK_EDITORCONFIG_OUTPUT='insert_final_newline=true'
		printf '\n%s\n\n' '${test_file}' | main -
	"
	[[ "${status}" -eq 0 ]]
}
