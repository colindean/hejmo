# Tests

## Running Tests Locally

### Prerequisites

Install bats and chezmoi probably using one of the Brewfiles in the root directory, or:

```bash
# On macOS and Linux
brew install bats-core chezmoi
```

### Running the Tests

```bash
# Run all tests
bats -p tests/*

# Run specific test
bats -f "chezmoi is installed" tests/test_chezmoi.bats
```

## Test Structure

The Chezmoi test suite verifies at least:

1. **Installation**: Chezmoi is properly installed and working
1. **Repository Structure**: `.chezmoiroot` file exists and points to `home/`
1. **Initialization**: Chezmoi source directory is correctly set up
1. **Symlinks**: All dotfiles are symlinked (not copied) to the home directory
1. **Content**: Symlinked files contain expected content
1. **Configuration**: Chezmoi config has symlink mode enabled
1. **Status**: Chezmoi reports no unexpected changes

## Continuous Integration

These tests run automatically on every push and pull request via GitHub Actions.
See `.github/workflows/test-chezmoi.yml` for the CI configuration.
