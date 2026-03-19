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

## Using Bitwarden as an SSH agent

[Bitwarden](https://bitwarden.com/) can act as an SSH agent, storing your SSH
keys securely in your vault and providing them to SSH via a local socket.

### Setup

1. Enable the SSH agent in the Bitwarden desktop app:
   **Settings → App settings → SSH agent → Enable SSH agent**

1. Add your SSH keys to your Bitwarden vault under **SSH Keys**.

1. Configure your shell to point `SSH_AUTH_SOCK` at the Bitwarden socket.
   Add the appropriate line to your shell profile (e.g. `~/.bash_profile`):

   **macOS:**

   ```sh
   export SSH_AUTH_SOCK=~/Library/Group\ Containers/LTZ2523XT1.net.bitwarden/t/agent.sock
   ```

   **Linux:**

   ```sh
   export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/bitwarden-ssh-agent.sock"
   ```

1. Create a drop-in config file here, e.g. `~/.ssh/config.d/bitwarden`, to
   tell SSH to prefer the Bitwarden-managed key for specific hosts:

   ```
   Host github.com
     IdentityAgent ~/Library/Group Containers/LTZ2523XT1.net.bitwarden/t/agent.sock

   Host gitlab.com
     IdentityAgent ~/Library/Group Containers/LTZ2523XT1.net.bitwarden/t/agent.sock
   ```

   On Linux, use the `IdentityAgent` value appropriate for your socket path.

### Verification

After setup, run `ssh-add -l` — you should see your Bitwarden-managed keys
listed. Then test with `ssh -T git@github.com` or `ssh -T git@gitlab.com`.
