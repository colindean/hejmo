
# setup zoxide
THIS_SHELL="$(basename "${SHELL}")"

if true && [ -n "$(command -v zoxide)" ]; then
  # Cache for 1 day (86400 seconds) since zoxide init output rarely changes
  case "${THIS_SHELL}" in
    bash)
      eval "$(bkt_cache_daily zoxide init bash)";;
    zsh)
      eval "$(bkt_cache_daily zoxide init zsh)";;
    *)
      eval "$(bkt_cache_daily zoxide init posix --hook prompt)";;
  esac
fi

# because the zoxide thing messes this up
export PROMPT_COMMAND="${PROMPT_COMMAND/;;/;}"
