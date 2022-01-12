#!/usr/bin/env bash
# git functions and aliases

if [ -n "$(command -v hub)" ]; then
  eval "$(hub alias -s)"
fi

alias g="git"
alias igist="GITHUB_URL=\${INTERNAL_GITHUB} gist"

alias debug_git="GIT_TRACE=true GIT_CURL_VERBOSE=true GIT_SSH_COMMAND='ssh -vvv' git"
