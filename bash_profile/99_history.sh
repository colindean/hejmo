#!/usr/bin/env bash
# history management

#prevent jrnl from appearing in history
export HISTIGNORE="$HISTIGNORE:jrnl *"
# load the last N into memory
export HISTSIZE=5000
# keep the last N on disk
export HISTFILESIZE=100000
export HISTTIMEFORMAT='[@ %Y-%m-%d %T] '
# append the history instead of overwriting it when there are multiple sessions
shopt -s histappend
# write every command to the history log immediately
#    this is expensive, because it must be appended, cleared, and re-read for
#    every command executed.
#    TODO: introduce something that can disable this for a session
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
