# SSH Config Include Directory

Files placed in this directory will be automatically included in the main
`~/.ssh/config` via the `Include config.d/*` directive at the top of that file.

This directory is listed in `.gitignore` so that files here are not tracked by
default. Use `git add --force` to add a file here if you want to track it.

## Example usage

Create a file such as `~/.ssh/config.d/work` with host entries specific to
your work environment:

```
Host bastion.example.com
  User myusername
  IdentityFile ~/.ssh/id_ed25519_work

Host *.internal.example.com
  ProxyJump bastion.example.com
  User myusername
  IdentityFile ~/.ssh/id_ed25519_work
```
