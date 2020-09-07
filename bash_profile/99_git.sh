if [ -n "$(command -v hub)" ]; then
  eval "$(hub alias -s)"
fi

alias g="git"
alias igist="GITHUB_URL=${INTERNAL_GITHUB} gist"
