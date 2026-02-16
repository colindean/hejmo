# Migration Guide: From Legacy Scripts to Chezmoi

This guide helps existing users migrate from the legacy `link_dotfiles.sh` and `link_dotbin.sh` scripts to the new Chezmoi-based setup.

## Why Migrate?

Chezmoi provides several advantages:

- **Symlink Mode**: Changes are immediately reflected without re-running scripts
- **Better Organization**: All dotfiles are in one place with clear naming
- **Template Support**: Customize configs per machine
- **Version Control**: Direct tracking of changes in git

## Migration Steps

### 1. Backup Existing Symlinks (Optional)

If you want to preserve your current setup temporarily:

```bash
# List current dotfile symlinks
ls -la ~ | grep "^l" > ~/dotfiles-backup.txt
```

### 2. Remove Old Symlinks

The old `link_dotfiles.sh` script created symlinks to the `dotfiles/` directory. These need to be removed before setting up chezmoi:

```bash
cd ~/Source/Personal/hejmo  # or wherever you cloned hejmo

# Remove dotfile symlinks
for f in dotfiles/*; do
  filename=$(basename "$f")
  rm -f "$HOME/.${filename}"
done

# If you previously used link_dotbin.sh, you can remove ~/.bin symlinks
# Note: Scripts are now accessed via PATH instead of symlinks
rm -rf ~/.bin
```

### 3. Setup Chezmoi

```bash
cd ~/Source/Personal/hejmo
bash scripts/hejmo-setup-chezmoi.sh --apply
```

This will:

1. Install chezmoi if not already installed
1. Link the `home/` directory to `~/.local/share/chezmoi`
1. Create symlinks for all dotfiles

**Note**: Scripts are now accessed via `$PATH` (configured in the repository's `bash_profile/00_hejmo_scripts.sh`, which is NOT managed by chezmoi) instead of being symlinked.

### 4. Verify Setup

Check that your dotfiles are now symlinks to the chezmoi source:

```bash
ls -la ~/.bashrc ~/.gitconfig ~/.vimrc
```

You should see symlinks pointing to `~/.local/share/chezmoi/dot_*` files.

Check that scripts are in your PATH:

```bash
which t  # or any other script from the scripts/ directory
echo $PATH | grep -o "${HEJMO}/scripts"
```

### 5. Test Your Shell

```bash
source ~/.bash_profile
# or
exec bash
```

## What Changed?

### File Locations

| Old Location         | New Location         | Deployed As          |
| -------------------- | -------------------- | -------------------- |
| `dotfiles/bashrc`    | `home/dot_bashrc`    | `~/.bashrc`          |
| `dotfiles/gitconfig` | `home/dot_gitconfig` | `~/.gitconfig`       |
| `scripts/t`          | `scripts/t`          | Available in `$PATH` |

### Setup Commands

| Old Way                 | New Way                      |
| ----------------------- | ---------------------------- |
| `bash link_dotfiles.sh` | `chezmoi apply`              |
| `bash link_dotbin.sh`   | Scripts accessed via `$PATH` |

## Rollback

If you need to rollback to the legacy setup:

```bash
cd ~/Source/Personal/hejmo

# Remove chezmoi symlinks
chezmoi destroy --force

# Remove chezmoi source link
rm ~/.local/share/chezmoi

# Re-apply legacy scripts
bash link_dotfiles.sh
bash link_dotbin.sh
```

## Getting Help

- Run `chezmoi doctor` to check for issues
- See `chezmoi help` for command documentation
- Check the [Chezmoi documentation](https://www.chezmoi.io/docs/)
