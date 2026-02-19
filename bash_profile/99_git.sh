#!/usr/bin/env bash
# git functions and aliases

if command -v hub > /dev/null; then
  # Cache for 1 day (86400 seconds) since hub alias rarely changes
  # shellcheck disable=SC2312
  eval "$(bkt_cache_daily hub alias -s)"
fi

alias g="git"
if [[ -n "${INTERNAL_GITHUB}" ]]; then
  alias igist="GITHUB_URL=\${INTERNAL_GITHUB} gist"
fi

alias debug_git="GIT_TRACE=true GIT_CURL_VERBOSE=true GIT_SSH_COMMAND='ssh -vvv' git"
