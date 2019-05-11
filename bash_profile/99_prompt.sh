#!/usr/bin/env bash
#command prompt customization

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

function emoji_number
{
  case $1 in
    1)
      echo "1️⃣";;
    2)
      echo "2️⃣";;
    3)
      echo "3️⃣";;
    4)
      echo "4️⃣";;
    5)
      echo "5️⃣";;
    6)
      echo "6️⃣";;
    7)
      echo "7️⃣";;
    8)
      echo "8️⃣";;
    9)
      echo "9️⃣";;
    10)
      echo "🔟";;
    *)
      echo "⏬";;
    esac
}

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
  local GIT_B="${RED}\$(if [ ! -z \"\`command -v __git_ps1\`\" ]; then _GITPS1=\"\`__git_ps1\`\"; if [ ! -z \"\${_GITPS1}\" ]; then echo -n \"±\${_GITPS1}\"; echo -n ' '; fi; fi)"
  local DEPTH="\$(if [ \$SHLVL -gt 1 ]; then echo \"⇟\$SHLVL\"; fi)"
  export PS1="${WHITE}[${YELLOW}\t ${GREEN}\u@\H ${CYAN}\w ${RUBY}${WHITE}]\n${GIT_B}${GRAY}${DEPTH}\$ "
}
prompt
