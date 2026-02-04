#!/usr/bin/env bats
bats_require_minimum_version 1.5.0

# Test suite for Bash startup
# These tests verify that bash starts correctly with applied dotfiles

setup() {
  # Run before each test
  export HOME="${HOME:-/home/runner}"
}

@test "bash starts successfully with applied dotfiles" {
  # Test that bash can start with the applied .bash_profile
  # This ensures changes to bash_profile files don't break startup
  run --separate-stderr bash -l -c 'echo "bash_startup_ok"'
  [ "$status" -eq 0 ]
  [[ "$output" =~ "bash_startup_ok" ]]
}

@test "bash_profile loads without errors" {
  # Start bash and check that HEJMO is set up correctly
  run --separate-stderr bash -l -c 'echo "${HEJMO}"'
  [ "$status" -eq 0 ]
  # HEJMO should be set to a non-empty path
  [ -n "$output" ]
  [[ "$output" =~ "\.local\/share\/chezmoi" ]]
}

@test "bkt helper functions are available after bash startup" {
  # Verify that bkt_cache_hourly and bkt_cache_daily functions exist
  run --separate-stderr bash -l -c 'type bkt_cache_hourly && type bkt_cache_daily'
  [ "$status" -eq 0 ]
  [[ "$output" =~ "bkt_cache_hourly is a function" ]]
  [[ "$output" =~ "bkt_cache_daily is a function" ]]
}
