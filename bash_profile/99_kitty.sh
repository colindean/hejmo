#!/usr/bin/env bash
# kitty terminal specific things
if [[ -z "${KITTY_PID}" ]]; then
	# not in kitty
	return 0
fi
export HEJMO_IS_KITTY=1

alias icat="kitten icat"
alias imgcat="kitten icat"

iplot() {
	# shellcheck disable=SC2312
	cat <<EOF | gnuplot
    set terminal pngcairo enhanced font 'Fira Sans,10'
    set autoscale
    set samples 1000
    set output '|kitty +kitten icat --stdin yes'
    set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgb"#fdf6e3" behind
    plot $@
    set output '/dev/null'
EOF
}
