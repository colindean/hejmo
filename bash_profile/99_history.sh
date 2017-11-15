#prevent jrnl from appearing in history
HISTIGNORE="$HISTIGNORE:jrnl *"
# load the last N into memory
HISTSIZE=5000
# keep the last N on disk
HISTFILESIZE=100000
# append the history instead of overwriting it when there are multiple sessions
shopt -s histappend
# write every command to the history log immediately
#    this is expensive, because it must be appended, cleared, and re-read for
#    every command executed.
#    TODO: introduce something that can disable this for a session
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
