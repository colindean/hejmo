# colindean's Home Directory Stuff

Abandon all hope, ye who enter here.

If something gets committed here that you think probably shouldn't be committed
here, please be a friend and tell me. I'll probably toss a few satoshis your
way.

## Quickstart on a new machine

I usually put this into `mkdir ~/Source/Personal` on my work machine or into `mkdir ~/Source/` on a personal machine.

```shell
mkdir -p ~/Source/Personal && cd ~/Source/Personal && \
git clone https://github.com/colindean/hejmo.git && cd hejmo
bash link_dotbin.sh && \
bash link_dotfiles.sh && \
bash setup-homebrew.sh

source ~/.bash_profile # or restart the terminal process

brew bundle --file=Brewfile.all && \
brew bundle --file=Brewfile.${INTENDED_HOSTNAME:-$(hostname)} && \
git remote set-url origin git@github.com:colindean/hejmo.git
```

On Debian Linux only:

```shell
bash setup-debian-derivs.sh && bash setup-docker-debian.sh
```

On macOS only:

```shell
# on work machine
export DISABLE_HOSTNAME_CHANGE=1
# set appropriately
export INTENDED_HOSTNAME=lusankya
bash setup-iterm.sh && bash setup-mac.sh
```

Then handle some standard tooling updates:

```shell
# install vim plugins with plug helper
plug install && plug update
```

And when I need them:

```shell
bash setup-rust.sh && \
bash setup-ruby.sh
```

You will see errors about:

- `__git_ps1` until both `git` and `bash-completion` are installed (from apt or Homebrew)
- `hub` until hub is install from Homebrew

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
