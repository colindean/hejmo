#!/usr/bin/env bash
function join { local IFS="$1"; shift; echo "$*"; }

__determine_brew_path(){
  local local_brew_path

  if [ -d "${HOME}/.linuxbrew" ]; then
    local_brew_path="${HOME}/.linuxbrew"
  elif [ -d "$(dirname "${HOME}")/linuxbrew/.linuxbrew" ]; then
    local_brew_path="$(dirname "${HOME}")/linuxbrew/.linuxbrew"
  elif [ -f "/usr/local/bin/brew" ]; then
    local_brew_path="/usr/local/"
  elif [ -f "/opt/homebrew/bin/brew" ]; then
    local_brew_path="/opt/homebrew"
  fi

  echo "${local_brew_path}"
}

# Setup PATH
MYPATH=()
## my scripts
MYPATH+=("${HOME}/.local/bin" "${HOME}/.bin")
## homebrew curl
MYPATH+=("$(__determine_brew_path)/opt/curl/bin")
## locally installed stuff, including homebrew
#MYPATH+=('/usr/local/bin:/usr/local/sbin')


eval "$("$(__determine_brew_path)/bin/brew" shellenv)"
[[ "Linux" == "$(uname -s)" ]] && \
  MYPATH+=("$(__determine_brew_path)/bin")
## java
if [[ "Linux" == "$(uname -s)" ]] && [[ -f /bin/update-alternatives ]]; then
  # update-alternatives gives ${JAVA_HOME}/jre/bin/java, so we gotta safely traverse upward
  if java_ua_output="$(/bin/update-alternatives --query java 2>/dev/null)"; then
    export JAVA_HOME="$(dirname $(dirname $(dirname $( echo "${java_ua_output}" | grep "^Value" | cut -f 2 -d ' '))))"
  fi
elif [[ "Darwin" == "$(uname -s)" ]]; then
  # macOS manages Java smartly
  export JAVA_HOME=/Library/Java/Home
else
  echo "Could not determine JAVA_HOME for $(uname -s) $(command -v lsb_release >/dev/null && lsb_release -sd || true) "
fi
if [[ -n "${JAVA_HOME}" ]]; then
  MYPATH+=("$JAVA_HOME/bin")
fi
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
if command -v pyenv >/dev/null; then
  eval "$(pyenv init --path)" && \
    eval "$(pyenv init -)"
  if pyenv virtualenv-init > /dev/null 2>&1; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi
