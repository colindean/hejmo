#!/usr/bin/env bash
# Checks if there is an internet connection on many different connectivity check URLs
# Adapted from https://antonz.org/is-online/

is_online() {
    local url="$1"
    local timeout=${2:-1}
    local response=$(
        curl \
        --output /dev/null \
        --write-out "%{http_code}" \
        --max-time "${timeout}" \
        --silent \
        "${url}"
    )
    if [[ "${response}" = "200" ]] || [[ "${response}" = "204" ]]; then
        return 0
    else
        return 1
    fi
}

declare -a candidates

candidates=(
  "http://google.com/generate_204"
  "http://detectportal.firefox.com/success.txt"
  "http://cp.cloudflare.com/generate_204"
  "http://edge-http.microsoft.com/captiveportal/generate_204"
  "http://connectivity-check.ubuntu.com"
  "http://connect.rom.miui.com/generate_204"
  "http://spectrum.s3.amazonaws.com/kindle-wifi/wifistub.html"
  "http://captive.apple.com/hotspot-detect.html"
  "http://network-test.debian.org/nm"
  "http://nmcheck.gnome.org/check_network_status.txt"
  "http://www.msftncsi.com/ncsi.txt"
)

for candidate in ${candidates[@]}; do
  printf "%d\t%s" $(is_online "${candidate}" "${1:-1}") "${candidate}"
done
