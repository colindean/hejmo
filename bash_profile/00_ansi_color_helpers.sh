#!/bin/bash

# TODO: metaprogram this so that it's all generated at execution/sourcing
export HEJMO_USE_ANSI="${HEJMO_USE_ANSI}"

ansi_escape(){
  if [[ $HEJMO_USE_ANSI -eq 1 ]]; then
    echo -en "[$@"
  fi
}
ansi_erase_display(){
  ansi_escape "2J"
}
ansi_erase_line(){
  ansi_escape "K"
}
ansi_reset(){
  ansi_escape "0m"
}
ansi_mode_bold(){
  ansi_escape "1m"
}
ansi_mode_faint(){
  ansi_escape "2m"
}
ansi_mode_italics(){
  ansi_escape "3m"
}
ansi_mode_underscore(){
  ansi_escape "4m"
}
ansi_mode_blink(){
  ansi_escape "5m"
}
ansi_mode_blink_rapid(){
  ansi_escape "6m"
}
ansi_mode_reverse_video(){
  ansi_escape "7m"
}
ansi_mode_concealed(){
  ansi_escape "8m"
}
ansi_mode_strike(){
  ansi_escape "9m"
}
ansi_mode_normal(){
  ansi_escape "22m"
}

ansi_color_fg_black(){   ansi_escape "30m";  }
ansi_color_fg_red(){     ansi_escape "31m";  }
ansi_color_fg_green(){   ansi_escape "32m";  }
ansi_color_fg_yellow(){  ansi_escape "33m";  }
ansi_color_fg_blue(){    ansi_escape "34m";  }
ansi_color_fg_magenta(){ ansi_escape "35m";  }
ansi_color_fg_cyan(){    ansi_escape "36m";  }
ansi_color_fg_white(){   ansi_escape "37m";  }
ansi_color_fg_default(){ ansi_escape "38m";  }

ansi_color_bg_black(){   ansi_escape "40m";  }
ansi_color_bg_red(){     ansi_escape "41m";  }
ansi_color_bg_green(){   ansi_escape "42m";  }
ansi_color_bg_yellow(){  ansi_escape "43m";  }
ansi_color_bg_blue(){    ansi_escape "44m";  }
ansi_color_bg_magenta(){ ansi_escape "45m";  }
ansi_color_bg_cyan(){    ansi_escape "46m";  }
ansi_color_bg_white(){   ansi_escape "47m";  }
ansi_color_bg_default(){ ansi_escape "48m";  }

ansi_demo(){
  echo -en "$(ansi_color_fg_white)Commencing demo…"
  echo -en "$(ansi_color_fg_black)K"
  echo -en "$(ansi_color_fg_red)R"
  echo -en "$(ansi_color_fg_green)G"
  echo -en "$(ansi_color_fg_yellow)Y"
  echo -en "$(ansi_color_fg_blue)B"
  echo -en "$(ansi_color_fg_magenta)M"
  echo -en "$(ansi_color_fg_cyan)C"
  echo -en "$(ansi_color_fg_white)W"
  echo -en "$(ansi_color_fg_default)D"
  echo -en "$(ansi_color_bg_black)K"
  echo -en "$(ansi_color_bg_red)R"
  echo -en "$(ansi_color_bg_green)G"
  echo -en "$(ansi_color_bg_yellow)$(ansi_color_fg_black)Y"
  echo -en "$(ansi_color_bg_blue)$(ansi_color_fg_white)B"
  echo -en "$(ansi_color_bg_magenta)M"
  echo -en "$(ansi_color_bg_cyan)$(ansi_color_fg_black)C"
  echo -en "$(ansi_color_bg_white)$(ansi_color_fg_black)W"
  echo -en "$(ansi_color_bg_default)D"
  echo -en "$(ansi_reset)$(ansi_color_fg_magenta)$(ansi_color_bg_black) LOOKING $(ansi_mode_bold)GOOD"
  echo -e "$(ansi_reset)"
}

if echo "${-}" | grep -q i; then
  export HEJMO_USE_ANSI=0
fi

if [[ -z "${HEJMO_USE_ANSI}" ]]; then
  if tput colors > /dev/null 2> /dev/null; then
    export HEJMO_USE_ANSI=1
  else
    export HEJMO_USE_ANSI=0
  fi
fi

if [[ "$BASH_SOURCE" == "$0" ]]; then
    ansi_demo
fi
