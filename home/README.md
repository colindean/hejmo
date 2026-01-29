# Chezmoi Source Directory

This directory contains the chezmoi source files for managing dotfiles.

The repository root contains a `.chezmoiroot` file that points to this `home/` directory, allowing chezmoi to know that the source files are in a subdirectory rather than at the repository root.

## File Naming Conventions

Chezmoi uses special naming conventions for files:

- Files starting with `dot_` become dotfiles in the home directory
  - `dot_bashrc` → `~/.bashrc`
  - `dot_gitconfig` → `~/.gitconfig`
- Directories starting with `dot_` become dot directories
  - `dot_config/` → `~/.config/`
  - `dot_vim/` → `~/.vim/`

## Directory Structure

```
home/
├── dot_ackrc           → ~/.ackrc
├── dot_bash_profile    → ~/.bash_profile
├── dot_gitconfig       → ~/.gitconfig
├── dot_vimrc           → ~/.vimrc
└── ...
```

**Note**: Scripts from the `scripts/` directory are NOT managed by chezmoi. Instead, they are added to your `$PATH` via the repository's bash profile configuration at `bash_profile/00_hejmo_scripts.sh` (this file is NOT in the chezmoi-managed `home/` directory).

## Usage

### Setup

Run the setup script from the repository root:

```bash
bash setup-chezmoi.sh
```

### Apply Configuration

To apply the chezmoi configuration and create symlinks:

```bash
chezmoi apply
```

### View Changes

To see what would change without applying:

```bash
chezmoi diff
```

### Add New Files

To add a new dotfile to chezmoi:

```bash
chezmoi add ~/.newfile
```

This will copy the file to the chezmoi source directory with the appropriate name.

## Symlink Mode

This configuration uses chezmoi in **symlink mode**, which means:

- Instead of copying files, chezmoi creates symlinks
- Changes to files in this directory are immediately reflected in your home directory
- You can edit files in place and they're automatically tracked by git

## More Information

For more details about chezmoi, see:
- [Chezmoi Documentation](https://www.chezmoi.io/docs/)
- [Chezmoi Quick Start](https://www.chezmoi.io/quick-start/)
