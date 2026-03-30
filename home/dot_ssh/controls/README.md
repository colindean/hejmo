# SSH Control Files Directory

This directory is used exclusively for SSH multiplexing control sockets,
created automatically by the `ControlPath` directive in `~/.ssh/config`.

These files are temporary sockets managed by OpenSSH and should never be
committed to version control. This directory is listed in `.gitignore`.
