#!/usr/bin/env bash

# move up directories quickly instead of cd ../; cd ../; etc/.
# adapted from http://www.bashoneliners.com/oneliners/oneliner/231/
up(){
  DEEP=${1:-"1"};
  OLDPWD_CACHE="${PWD}"
  for i in $(seq 1 ${DEEP}); do
    cd ../;
  done;
  export OLDPWD="${OLDPWD_CACHE}"
}

hejmo(){
  cd "${HEJMO}"
  [[ -n "$(command -v tabname)" ]] && tabname
}

# setup zoxide
THIS_SHELL="$(basename "${SHELL}")"

if [ -n "$(command -v zoxide)" ]; then
  case "${THIS_SHELL}" in
    bash)
      eval "$(zoxide init bash)";;
    zsh)
      eval "$(zoxide init zsh)";;
    *)
      eval "$(zoxide init posix --hook prompt)";;
  esac
fi
