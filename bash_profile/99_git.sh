#!/usr/bin/env bash
# git functions and aliases

alias g="git"
# shellcheck disable=SC2154
alias igist="GITHUB_URL=\${INTERNAL_GITHUB} gist"

alias debug_git="GIT_TRACE=true GIT_CURL_VERBOSE=true GIT_SSH_COMMAND='ssh -vvv' git"
