#!/bin/bash
# shellcheck disable=SC2312

# disabled SC2312 because of extensive use of function calls for interpolation

# TODO: metaprogram this so that it's all generated at execution/sourcing
export HEJMO_USE_ANSI="${HEJMO_USE_ANSI}"

ansi_escape(){
  if [[ ${HEJMO_USE_ANSI} -eq 1 ]]; then
    echo -en "[${*}"
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

ansi_color_fg_black_bold(){   ansi_escape "1;30m";  }
ansi_color_fg_red_bold(){     ansi_escape "1;31m";  }
ansi_color_fg_green_bold(){   ansi_escape "1;32m";  }
ansi_color_fg_yellow_bold(){  ansi_escape "1;33m";  }
ansi_color_fg_blue_bold(){    ansi_escape "1;34m";  }
ansi_color_fg_magenta_bold(){ ansi_escape "1;35m";  }
ansi_color_fg_cyan_bold(){    ansi_escape "1;36m";  }
ansi_color_fg_white_bold(){   ansi_escape "1;37m";  }
ansi_color_fg_default_bold(){ ansi_escape "1;38m";  }

ansi_color_fg_black_underline(){   ansi_escape "4;30m";  }
ansi_color_fg_red_underline(){     ansi_escape "4;31m";  }
ansi_color_fg_green_underline(){   ansi_escape "4;32m";  }
ansi_color_fg_yellow_underline(){  ansi_escape "4;33m";  }
ansi_color_fg_blue_underline(){    ansi_escape "4;34m";  }
ansi_color_fg_magenta_underline(){ ansi_escape "4;35m";  }
ansi_color_fg_cyan_underline(){    ansi_escape "4;36m";  }
ansi_color_fg_white_underline(){   ansi_escape "4;37m";  }
ansi_color_fg_default_underline(){ ansi_escape "4;38m";  }

ansi_color_fg_black_high(){   ansi_escape "90m";  }
ansi_color_fg_red_high(){     ansi_escape "91m";  }
ansi_color_fg_green_high(){   ansi_escape "92m";  }
ansi_color_fg_yellow_high(){  ansi_escape "93m";  }
ansi_color_fg_blue_high(){    ansi_escape "94m";  }
ansi_color_fg_magenta_high(){ ansi_escape "95m";  }
ansi_color_fg_cyan_high(){    ansi_escape "96m";  }
ansi_color_fg_white_high(){   ansi_escape "97m";  }
ansi_color_fg_default_high(){ ansi_escape "98m";  }

ansi_color_fg_black_bold_high(){   ansi_escape "1;90m";  }
ansi_color_fg_red_bold_high(){     ansi_escape "1;91m";  }
ansi_color_fg_green_bold_high(){   ansi_escape "1;92m";  }
ansi_color_fg_yellow_bold_high(){  ansi_escape "1;93m";  }
ansi_color_fg_blue_bold_high(){    ansi_escape "1;94m";  }
ansi_color_fg_magenta_bold_high(){ ansi_escape "1;95m";  }
ansi_color_fg_cyan_bold_high(){    ansi_escape "1;96m";  }
ansi_color_fg_white_bold_high(){   ansi_escape "1;97m";  }
ansi_color_fg_default_bold_high(){ ansi_escape "1;98m";  }

ansi_color_bg_black(){   ansi_escape "40m";  }
ansi_color_bg_red(){     ansi_escape "41m";  }
ansi_color_bg_green(){   ansi_escape "42m";  }
ansi_color_bg_yellow(){  ansi_escape "43m";  }
ansi_color_bg_blue(){    ansi_escape "44m";  }
ansi_color_bg_magenta(){ ansi_escape "45m";  }
ansi_color_bg_cyan(){    ansi_escape "46m";  }
ansi_color_bg_white(){   ansi_escape "47m";  }
ansi_color_bg_default(){ ansi_escape "48m";  }

ansi_color_bg_black_high(){   ansi_escape "100m";  }
ansi_color_bg_red_high(){     ansi_escape "101m";  }
ansi_color_bg_green_high(){   ansi_escape "102m";  }
ansi_color_bg_yellow_high(){  ansi_escape "103m";  }
ansi_color_bg_blue_high(){    ansi_escape "104m";  }
ansi_color_bg_magenta_high(){ ansi_escape "105m";  }
ansi_color_bg_cyan_high(){    ansi_escape "106m";  }
ansi_color_bg_white_high(){   ansi_escape "107m";  }
ansi_color_bg_default_high(){ ansi_escape "108m";  }

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

  echo -en "$(ansi_reset)"

  echo -en "$(ansi_color_fg_black_bold)K"
  echo -en "$(ansi_color_fg_red_bold)R"
  echo -en "$(ansi_color_fg_green_bold)G"
  echo -en "$(ansi_color_fg_yellow_bold)Y"
  echo -en "$(ansi_color_fg_blue_bold)B"
  echo -en "$(ansi_color_fg_magenta_bold)M"
  echo -en "$(ansi_color_fg_cyan_bold)C"
  echo -en "$(ansi_color_fg_white_bold)W"
  echo -en "$(ansi_color_fg_default_bold)D"

  echo -en "$(ansi_reset)"

  echo -en "$(ansi_color_fg_black_underline)K"
  echo -en "$(ansi_color_fg_red_underline)R"
  echo -en "$(ansi_color_fg_green_underline)G"
  echo -en "$(ansi_color_fg_yellow_underline)Y"
  echo -en "$(ansi_color_fg_blue_underline)B"
  echo -en "$(ansi_color_fg_magenta_underline)M"
  echo -en "$(ansi_color_fg_cyan_underline)C"
  echo -en "$(ansi_color_fg_white_underline)W"
  echo -en "$(ansi_color_fg_default_underline)D"

  echo -en "$(ansi_reset)"

  echo -en "$(ansi_color_fg_black_high)K"
  echo -en "$(ansi_color_fg_red_high)R"
  echo -en "$(ansi_color_fg_green_high)G"
  echo -en "$(ansi_color_fg_yellow_high)Y"
  echo -en "$(ansi_color_fg_blue_high)B"
  echo -en "$(ansi_color_fg_magenta_high)M"
  echo -en "$(ansi_color_fg_cyan_high)C"
  echo -en "$(ansi_color_fg_white_high)W"
  echo -en "$(ansi_color_fg_default_high)D"

  echo -en "$(ansi_reset)"

  echo -en "$(ansi_color_fg_black_bold_high)K"
  echo -en "$(ansi_color_fg_red_bold_high)R"
  echo -en "$(ansi_color_fg_green_bold_high)G"
  echo -en "$(ansi_color_fg_yellow_bold_high)Y"
  echo -en "$(ansi_color_fg_blue_bold_high)B"
  echo -en "$(ansi_color_fg_magenta_bold_high)M"
  echo -en "$(ansi_color_fg_cyan_bold_high)C"
  echo -en "$(ansi_color_fg_white_bold_high)W"
  echo -en "$(ansi_color_fg_default_bold_high)D"

  echo -en "$(ansi_reset)"

  echo -en "$(ansi_color_bg_black)K"
  echo -en "$(ansi_color_bg_red)R"
  echo -en "$(ansi_color_bg_green)G"
  echo -en "$(ansi_color_bg_yellow)$(ansi_color_fg_black)Y"
  echo -en "$(ansi_color_bg_blue)$(ansi_color_fg_white)B"
  echo -en "$(ansi_color_bg_magenta)M"
  echo -en "$(ansi_color_bg_cyan)$(ansi_color_fg_black)C"
  echo -en "$(ansi_color_bg_white)$(ansi_color_fg_black)W"
  echo -en "$(ansi_color_bg_default)D"

  echo -en "$(ansi_reset)"

  echo -en "$(ansi_color_bg_black_high)K"
  echo -en "$(ansi_color_bg_red_high)R"
  echo -en "$(ansi_color_bg_green_high)G"
  echo -en "$(ansi_color_bg_yellow_high)$(ansi_color_fg_black_high)Y"
  echo -en "$(ansi_color_bg_blue_high)$(ansi_color_fg_white_high)B"
  echo -en "$(ansi_color_bg_magenta_high)M"
  echo -en "$(ansi_color_bg_cyan_high)$(ansi_color_fg_black_high)C"
  echo -en "$(ansi_color_bg_white_high)$(ansi_color_fg_black_high)W"
  echo -en "$(ansi_color_bg_default_high)D"

  echo -en "$(ansi_reset)$(ansi_color_fg_magenta)$(ansi_color_bg_black) LOOKING $(ansi_mode_bold)GOOD"
  echo -e "$(ansi_reset)"
}

if echo "${-}" | grep -qv i; then
  >&2 echo "Avoiding ANSI because \$- has no 'i': [${-}]"
  export HEJMO_USE_ANSI=0
fi

if [[ -z "${HEJMO_USE_ANSI}" ]]; then
  if tput colors > /dev/null 2> /dev/null; then
    export HEJMO_USE_ANSI=1
  else
    export HEJMO_USE_ANSI=0
  fi
fi

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    ansi_demo
fi
