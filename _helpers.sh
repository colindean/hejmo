#!/bin/sh

command_exists() {
  local cmd="$1"
  command -v ${cmd} >/dev/null 2>&1
}

install_homebrew() {
  local homebrew_installer_url="https://raw.githubusercontent.com/Homebrew/install/master/install"
  
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
  for package in `cat ${listfile}`; do
    local clean_package=$(echo ${package} | sed -e 's/\//\\\//g')
    local cmd=$(echo "${cmd_template}" | sed -e "s/\%PACKAGE\%/${clean_package}/g")
    $cmd
  done
}
