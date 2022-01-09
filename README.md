# colindean's Home Directory Stuff

Abandon all hope, ye who enter here.

If something gets committed here that you think probably shouldn't be committed
here, please be a friend and tell me. I'll probably toss a few satoshis your
way.

## Quickstart on a new machine

I usually put this into `mkdir ~/Source/Personal` on my work machine or into `mkdir ~/Source/` on a personal machine.

```bash
git clone https://github.com/colindean/hejmo.git && cd hejmo
bash link_dotbin.sh && \
bash link_dotfiles.sh && \
bash setup-homebrew.sh && \
brew bundle --file=Brewfile.all && \
brew bundle --file=Brewfile.$(hostname) && \
git remote set-url origin git@github.com:colindean/hejmo.git
```

On Linux only:

```
bash setup-debian-derivs.sh && bash setup-docker-linux.sh
```

On macOS only:

```
bash setup-iterm.sh
```

And when I need them:


```
bash setup-rust.sh && \
bash setup-ruby.sh
```

You will see errors about:

* `__git_ps1` until both `git` and `bash-completion` are installed (from apt or Homebrew)
* `hub` until hub is install from Homebrew

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
