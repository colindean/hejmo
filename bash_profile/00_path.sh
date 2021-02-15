#!/usr/bin/env bash
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home
export JAVA_HOME=/Library/Java/Home
function join { local IFS="$1"; shift; echo "$*"; }
# Setup PATH
MYPATH=()
## my scripts
MYPATH+=("${HOME}/.bin")
## brew's python
MYPATH+=('/usr/local/opt/python/libexec/bin')
## homebrew curl
MYPATH+=('/usr/local/opt/curl/bin')
## homebrew
MYPATH+=('/usr/local/bin:/usr/local/sbin')
LINUXBREW_PATH="${LINUXBREW_PATH:-/home/linuxbrew/.linuxbrew}"
[[ "Linux" == "$(uname -s)" ]] && \
  [[ -d "${LINUXBREW_PATH}/bin" ]] && \
  MYPATH+=("${LINUXBREW_PATH}/bin")
## java
MYPATH+=("$JAVA_HOME/bin")
## rust
MYPATH+=("$HOME/.cargo/bin:$PATH")
MYPATH+=('/usr/local/opt/rust/bin')

## haskell
MYPATH+=("$HOME/.cabal/bin")

## heroku
MYPATH+=("/usr/local/heroku/bin")

## go
MYPATH+=("/usr/local/opt/go/libexec/bin")
export GOPATH="${HOME}/.go"

## coursier
COURSIER_BIN_MAC="${HOME}/Library/Application Support/Coursier/bin"
COURSIER_BIN_LINUX="${HOME}/.local/share/coursier/bin"
if [ -z "${COURSIER_BIN_DIR}" ]; then
  case "$(uname -s)" in
    Darwin)
      [[ -d "${COURSIER_BIN_MAC}" ]] && COURSIER_BIN_DIR="${COURSIER_BIN_MAC}" ;;
    Linux)
      [[ -d "${COURSIER_BIN_LINUX}" ]] && COURSIER_BIN_DIR="${COURSIER_BIN_LINUX}" ;;
  esac
fi
if [ -n "${COURSIER_BIN_DIR}" ]; then
  MYPATH+=("${COURSIER_BIN_DIR}")
fi

## PATHS, ASSEMBLE
JOINED_PATH=$(join : "${MYPATH[@]}")
export PATH=$JOINED_PATH:$PATH

## pyenv, the slow one
if [[ -n "$(command -v pyenv)" ]]; then
  eval "$(pyenv init -)"
fi
