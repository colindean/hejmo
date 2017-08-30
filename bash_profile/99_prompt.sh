#command prompt customization

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
source "${HEJMO}/upsearch.sh"
function prompt
{
  local WHITE="\[\033[1;37m\]"
  local GREEN="\[\033[0;32m\]"
  local CYAN="\[\033[0;36m\]"
  local GRAY="\[\033[0;37m\]"
  local BLUE="\[\033[0;34m\]"
  local LIGHT_BLUE="\[\033[1;34m\]"
  local YELLOW="\[\033[1;33m\]"
  local RED="\[\033[1;31m\]"
  #local RUBY="${LIGHT_BLUE}\$(if [ ! -z \"\`upsearch Gemfile\`\" ]; then echo -n \"(\${RUBY_VERSION})\"; fi)"
  local GIT_B="${RED}\$(_GITPS1=\"\`__git_ps1\`\"; if [ ! -z \"\${_GITPS1}\" ]; then echo -n \"±\${_GITPS1}\"; echo -n ' '; fi)"
  export PS1="${WHITE}[${YELLOW}\t ${GREEN}\u@\H ${CYAN}\w ${RUBY}${WHITE}]\n${GIT_B}${GRAY}\$ "
}
prompt
