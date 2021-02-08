
# setup zoxide
THIS_SHELL="$(basename "${SHELL}")"

if true && [ -n "$(command -v zoxide)" ]; then
  case "${THIS_SHELL}" in
    bash)
      eval "$(zoxide init bash)";;
    zsh)
      eval "$(zoxide init zsh)";;
    *)
      eval "$(zoxide init posix --hook prompt)";;
  esac
fi
