#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home
export JAVA_HOME=/Library/Java/Home
function join { local IFS="$1"; shift; echo "$*"; }
# Setup PATH
MYPATH=()
## my scripts
MYPATH+=('~/.bin')
## brew's python
MYPATH+=('/usr/local/opt/python/libexec/bin')
## homebrew curl
MYPATH+=('/usr/local/opt/curl/bin')
## homebrew
MYPATH+=('/usr/local/bin:/usr/local/sbin')
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

JOINED_PATH=$(join : "${MYPATH[@]}")
export PATH=$JOINED_PATH:$PATH
