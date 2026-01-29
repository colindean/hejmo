# Chezmoi Integration Tests

This directory contains tests for the Chezmoi integration in the Hejmo repository.

## Running Tests Locally

### Prerequisites

1. Install BATS (Bash Automated Testing System):
   ```bash
   # On macOS
   brew install bats-core
   
   # On Ubuntu/Debian
   sudo apt-get install bats
   
   # Or install from source
   git clone https://github.com/bats-core/bats-core.git
   cd bats-core
   sudo ./install.sh /usr/local
   ```

2. Install chezmoi:
   ```bash
   # See https://www.chezmoi.io/install/
   brew install chezmoi  # macOS
   # or
   sudo snap install chezmoi --classic  # Linux
   ```

### Running the Tests

```bash
# Run all tests
bats tests/test_chezmoi.bats

# Run with verbose output
bats -p tests/test_chezmoi.bats

# Run specific test
bats -f "chezmoi is installed" tests/test_chezmoi.bats
```

## Test Structure

The test suite verifies:

1. **Installation**: Chezmoi is properly installed and working
2. **Repository Structure**: `.chezmoiroot` file exists and points to `home/`
3. **Initialization**: Chezmoi source directory is correctly set up
4. **Symlinks**: All dotfiles are symlinked (not copied) to the home directory
5. **Content**: Symlinked files contain expected content
6. **Configuration**: Chezmoi config has symlink mode enabled
7. **Status**: Chezmoi reports no unexpected changes

## Continuous Integration

These tests run automatically on every push and pull request via GitHub Actions.
See `.github/workflows/test-chezmoi.yml` for the CI configuration.
