#!/usr/bin/env bash
# mostly copied from https://github.com/tednaleid/shared-zshrc/blob/master/zshrc_base#L265-L279

[[ "$(uname -s)" == "Darwin" ]] && XARGS="gxargs" || XARGS="xargs"

default_fzf_location=/usr/local/opt/fzf
[[ -n "$(command -v brew)" ]] && BREW_FZF="$(${BREW_PREFIX} fzf)"
FZF_SHELL="${BREW_FZF:-$default_fzf_location}/shell"

if [[ -d "$FZF_SHELL" ]]; then
  source "${FZF_SHELL}/completion.bash" 2> /dev/null
  source "${FZF_SHELL}/key-bindings.bash"
# end if we have fzf
fi

export FZF_CTRL_R_OPTS="--min-height=20 --exact --preview 'echo {}' --preview-window down:3:wrap"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,build}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_CTRL_T_OPTS=$'--min-height=20 --preview \'[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file ||
                (bat --style=numbers --color=always {} ||
                  cat {}) 2> /dev/null | head -500
\''

export FZF_DEFAULT_OPTS="
  --layout=reverse
  --info=inline
  --height=80%
  --bind '?:toggle-preview'
"
alias fzfp="fzf $FZF_CTRL_T_OPTS"

# needs findutils for gxargs and fd for better find
# open a file somewhere under the current directory, press "?" for preview window
open_fzf() {
  fd -t f -L -H -E ".git" |\
    fzf -m --min-height=20 \
      --preview-window=:hidden \
      --preview '[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -500' |\
    "${XARGS}" -ro -d "\n" open
}

# cd into a directory based on and fzf directory search
cd_fzf() {
  local basedir=${1:-.} # default to starting from current directory (.) but allow override
  local directory
  if directory=$(fd -t d -L -H -I -E ".git" . "$basedir" | fzf --preview="tree -L 1 {}" ); then
    cd $directory && fzf-redraw-prompt
  fi
}

# cd into a directory somewhere under the home directory
cd_home_fzf() {
  cd_fzf "$HOME"
}


