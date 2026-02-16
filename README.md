# colindean's Home Directory Stuff

Abandon all hope, ye who enter here.

If something gets committed here that you think probably shouldn't be committed
here, please be a friend and tell me. I'll probably toss a few satoshis your
way.

## Quickstart on a new machine

```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/colindean/hejmo.git
```

### Option 1: Using Chezmoi (Recommended)

```shell
# Load a new shell or run this to load up Hejmo's bash config:
source ~/.bash_profile
# Setup Homebrew and install packages
hejmo-setup-homebrew.sh

brew bundle --file=${HEJMO}/Brewfile.all && \
brew bundle --file=${HEJMO}/Brewfile.${INTENDED_HOSTNAME:-$(hostname)} && \
git remote set-url origin git@github.com:colindean/hejmo.git
```

On Debian Linux only:

```shell
hejmo-setup-debian-derivs.sh && hejmo-setup-docker-debian.sh
```

On macOS only:

```shell
# on work machine
export DISABLE_HOSTNAME_CHANGE=1
# set appropriately
export INTENDED_HOSTNAME=lusankya
hejmo-setup-mac.sh
```

Then handle some standard tooling updates:

```shell
# install vim plugins with plug helper
plug install && plug update
```

And when I need them:

```shell
hejmo-setup-ruby.sh
```

You will see errors about:

- `__git_ps1` until both `git` and `bash-completion` are installed (from apt or Homebrew)
- `hub` until hub is install from Homebrew

## About Chezmoi

This repository now uses [Chezmoi](https://www.chezmoi.io/) for dotfile management. Chezmoi provides several benefits:

- **Symlink Mode**: Changes to dotfiles are immediately reflected without needing to re-run setup scripts
- **Cross-machine Management**: Easily manage dotfiles across multiple machines with different configurations
- **Template Support**: Use templates to customize dotfiles per machine (hostname, OS, etc.)
- **Security**: Built-in support for encrypted files (e.g., for secrets)
- **Version Control**: All dotfiles are tracked in git and changes are immediately visible

### Chezmoi Commands

```shell
# View what would change
chezmoi diff

# Apply changes (create/update symlinks)
chezmoi apply

# Add a new dotfile
chezmoi add ~/.newfile

# Edit a dotfile
chezmoi edit ~/.bashrc

# Update from repository
cd ~/Source/Personal/hejmo && git pull
```

The dotfiles are stored in the `home/` directory with chezmoi naming conventions (e.g., `dot_bashrc` → `~/.bashrc`). The repository includes a `.chezmoiroot` file at the root that tells chezmoi the source directory is `home/`. Scripts from the `scripts/` directory are available in your `$PATH` automatically once your bash profile is loaded (configured in the repository's `bash_profile/00_hejmo_scripts.sh`).

## Things to copy

These files diverge quickly, so I don't version them and instead copypaste them when necessary. Maybe others will find them to be a useful starting point!

### `~/.ssh/config`

Run `mkdir -p ~/.ssh/controls` first and then put this content into the above file:

```
Host *
  UseRoaming no
  Protocol 2
  Compression yes
  ControlMaster auto
  ControlPath ~/.ssh/controls/sshcontrol-%r@%h:%p
```
