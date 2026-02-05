#!/usr/bin/env bats
bats_require_minimum_version 1.5.0

# Test suite for screenshot_cleanup.sh
# These tests verify the screenshot cleanup script functions

setup() {
  # Source the script to test its functions
  export SCREENSHOT_DIR=""
  export ARCHIVE_DIR=""
  export DRY_RUN=true
  
  # Source the script
  source "${BATS_TEST_DIRNAME}/../scripts/screenshot_cleanup.sh"
  
  # Create temporary test directory
  TEST_DIR="${BATS_TEST_TMPDIR}/screenshots"
  mkdir -p "$TEST_DIR"
}

teardown() {
  # Clean up test directory
  rm -rf "${BATS_TEST_TMPDIR}/screenshots"
}

@test "get_screenshot_dir returns a valid directory on Linux" {
  # Mock uname to return Linux
  uname() { echo "Linux"; }
  export -f uname
  
  run get_screenshot_dir
  [ "$status" -eq 0 ]
  # Should return a path (either from gsettings or default)
  [[ "$output" =~ ^/ ]] || [[ "$output" =~ ^\$ ]]
}

@test "get_screenshot_dir returns a valid directory on macOS" {
  # Mock uname to return Darwin
  uname() { echo "Darwin"; }
  export -f uname
  
  # Mock defaults command
  defaults() {
    if [[ "$1" == "read" ]]; then
      echo "/Users/test/Desktop"
    fi
  }
  export -f defaults
  
  run get_screenshot_dir
  [ "$status" -eq 0 ]
  [ "$output" = "/Users/test/Desktop" ]
}

@test "get_screenshot_pattern returns macOS pattern" {
  # Mock uname to return Darwin
  uname() { echo "Darwin"; }
  export -f uname
  
  run get_screenshot_pattern
  [ "$status" -eq 0 ]
  [[ "$output" =~ "at" ]]
}

@test "get_screenshot_pattern returns Linux pattern" {
  # Mock uname to return Linux
  uname() { echo "Linux"; }
  export -f uname
  
  run get_screenshot_pattern
  [ "$status" -eq 0 ]
  [[ "$output" =~ "from" ]]
}

@test "extract_timestamp works for macOS screenshot filename" {
  # Mock uname to return Darwin
  uname() { echo "Darwin"; }
  export -f uname
  
  run extract_timestamp "Screenshot 2024-01-15 at 10.30.45 AM.png"
  [ "$status" -eq 0 ]
  [ "$output" = "2024-01-15 10:30:45" ]
}

@test "extract_timestamp works for macOS screenshot filename without AM/PM" {
  # Mock uname to return Darwin
  uname() { echo "Darwin"; }
  export -f uname
  
  run extract_timestamp "Screenshot 2024-01-15 at 14.30.45.png"
  [ "$status" -eq 0 ]
  [ "$output" = "2024-01-15 14:30:45" ]
}

@test "extract_timestamp works for Linux screenshot filename" {
  # Mock uname to return Linux
  uname() { echo "Linux"; }
  export -f uname
  
  run extract_timestamp "Screenshot from 2024-01-15 10-30-45.png"
  [ "$status" -eq 0 ]
  [ "$output" = "2024-01-15 10:30:45" ]
}

@test "extract_timestamp fails for invalid filename" {
  # Mock uname to return Darwin
  uname() { echo "Darwin"; }
  export -f uname
  
  run extract_timestamp "invalid_filename.png"
  [ "$status" -eq 1 ]
  [[ "$output" =~ "Error" ]]
}

@test "age_in_days calculates age correctly on Linux" {
  # Mock uname to return Linux
  uname() { echo "Linux"; }
  export -f uname
  
  # Calculate a timestamp from 10 days ago
  local ten_days_ago
  ten_days_ago=$(date -d "10 days ago" "+%Y-%m-%d %H:%M:%S")
  
  run age_in_days "$ten_days_ago"
  [ "$status" -eq 0 ]
  # Should be approximately 10 days (allow for timing variance)
  [[ "$output" -ge 9 ]] && [[ "$output" -le 11 ]]
}

@test "age_in_days calculates zero days for current timestamp on Linux" {
  # Mock uname to return Linux
  uname() { echo "Linux"; }
  export -f uname
  
  # Current timestamp
  local now
  now=$(date "+%Y-%m-%d %H:%M:%S")
  
  run age_in_days "$now"
  [ "$status" -eq 0 ]
  [ "$output" -eq 0 ]
}

@test "trash function outputs correct message in dry run" {
  export DRY_RUN=true
  
  run trash "$TEST_DIR/test_file.png"
  [ "$status" -eq 0 ]
  [[ "$output" =~ "🗑 ⬅ test_file.png" ]]
}

@test "archive function creates directory and moves file in dry run" {
  export DRY_RUN=true
  local archive_dir="$TEST_DIR/archive"
  
  # Create a test file
  touch "$TEST_DIR/test_file.png"
  
  run archive "$TEST_DIR/test_file.png" "$archive_dir"
  [ "$status" -eq 0 ]
  [[ "$output" =~ "🗄 ⬅ test_file.png" ]]
  [[ "$output" =~ "Creating" ]]
}

@test "archive function works when directory exists" {
  export DRY_RUN=true
  local archive_dir="$TEST_DIR/archive"
  mkdir -p "$archive_dir"
  
  # Create a test file
  touch "$TEST_DIR/test_file.png"
  
  run archive "$TEST_DIR/test_file.png" "$archive_dir"
  [ "$status" -eq 0 ]
  [[ "$output" =~ "🗄 ⬅ test_file.png" ]]
  # Should not output "Creating" since directory exists
  [[ ! "$output" =~ "Creating" ]]
}

@test "process_archive handles non-existent directory gracefully" {
  export DRY_RUN=true
  
  run process_archive "$TEST_DIR/nonexistent" 15
  [ "$status" -eq 0 ]
  [[ "$output" =~ "does not exist" ]]
}

@test "process_screenshots handles non-existent directory gracefully" {
  export DRY_RUN=true
  
  run process_screenshots "$TEST_DIR/nonexistent" "$TEST_DIR/archive" 7
  [ "$status" -eq 0 ]
  [[ "$output" =~ "does not exist" ]]
}

@test "process_screenshots finds and processes files" {
  # Mock uname to return Linux for easier testing
  uname() { echo "Linux"; }
  export -f uname
  export DRY_RUN=true
  
  # Create test files with valid Linux screenshot names
  local old_date
  old_date=$(date -d "10 days ago" "+%Y-%m-%d")
  local old_time="10-30-45"
  touch "$TEST_DIR/Screenshot from ${old_date} ${old_time}.png"
  
  local recent_date
  recent_date=$(date "+%Y-%m-%d")
  local recent_time="10-30-45"
  touch "$TEST_DIR/Screenshot from ${recent_date} ${recent_time}.png"
  
  run process_screenshots "$TEST_DIR" "$TEST_DIR/archive" 7
  [ "$status" -eq 0 ]
  # Should show archival message for old file and keep message for recent file
  [[ "$output" =~ "🗄 ⬅" ]] || [[ "$output" =~ "📂 ⬇" ]]
}

@test "main function can be called without errors" {
  # Mock uname to return Linux
  uname() { echo "Linux"; }
  export -f uname
  export DRY_RUN=true
  export SCREENSHOT_DIR="$TEST_DIR"
  export ARCHIVE_DIR="$TEST_DIR/archive"
  
  run main
  [ "$status" -eq 0 ]
  [[ "$output" =~ "Screenshot directory" ]]
  [[ "$output" =~ "Archive directory" ]]
}

@test "script is executable" {
  [ -x "${BATS_TEST_DIRNAME}/../scripts/screenshot_cleanup.sh" ]
}

@test "script can be sourced without errors" {
  run bash -c "source ${BATS_TEST_DIRNAME}/../scripts/screenshot_cleanup.sh; echo 'sourced'"
  [ "$status" -eq 0 ]
  [[ "$output" =~ "sourced" ]]
}
