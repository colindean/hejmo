#!/bin/sh

command_exists() {
  local cmd="$1"
  command -v ${cmd} >/dev/null 2>&1
}

install_homebrew() {
  local homebrew_installer_url="https://raw.githubusercontent.com/Homebrew/install/master/install"

  command_exists "curl"
  curl_exists=$?
  if [[ $curl_exists -ne 0 ]]; then
    echo >&2 "curl isn't available. What's up?"
    exit 2
  fi

  command_exists "ruby"
  ruby_exists=$?
  if [[ $ruby_exists -ne 0 ]]; then
    echo >&2 "ruby isn't available. What's up?"
    exit 2
  fi

  ruby -e "$(curl -fsSL ${homebrew_installer_url})"
}

install_packages() {
  local listfile="$1"
  local cmd_template="$2"
  oldifs="${IFS}"
  IFS=$'\n'

  failed=()
  for package in `cat ${listfile}`; do
    local clean_package=$(echo ${package} | sed -e 's/\//\\\//g')
    local cmd=$(echo "${cmd_template}" | sed -e "s/\%PACKAGE\%/${clean_package}/g")
    eval $cmd
    if [[ $? -ne 0 ]]; then
      failed+=("$package")
    fi
  done
  IFS="${oldifs}"
  if [[ ${#failed[@]} -gt 0 ]]; then
    echo "These packages failed to install:"
    printf "\t%s\n" "${failed[@]}"
    echo "You can to rerun this script until this message disappears."
    echo "Inspect the transcript to find more exact errors."
  fi
}

# from_dir must be an absolute path!
link_all_files_in_dir() {
  from_dir="$1"
  to_dir="$2"
  rm="$3"
  prepend="$4"

  case "$(uname -s)" in
    Darwin) LN_OPTIONS="sFf" ;;
    Linux) LN_OPTIONS="sf" ;;
    # TODO: determine safe defaults for OSes I never use
    *) LN_OPTIONS="sf" ;;
  esac

  for f in $(ls "${from_dir}"); do
    TARGET="${from_dir}/${f}"
    LINK="${to_dir}/${prepend}${f}"
    if [[ ! -z $rm ]]; then
      echo "Removing ${LINK}"
      rm -f "${LINK}"
    fi
    echo "Linking ${LINK} to ${TARGET}"
    ln -sFf "${TARGET}" "${LINK}"
  done
}
