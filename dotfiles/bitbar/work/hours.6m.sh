#!/usr/bin/env bash
# <bitbar.title>Time checker</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>colindean</bitbar.author>
# <bitbar.author.github>colindean</bitbar.author.github>
# <bitbar.desc>
#   Runs `t hours` to show the current hours logged today
# </bitbar.desc>

#Unfortunately, t requires basically everything.

export TERM=mac
. "$HOME/.bash_profile"
T="$HOME/.bin/t"


if [[ ! -f "${T}" ]]; then
  echo "⚠️  t"
  exit 1
fi

OUTPUT="$("${T}" hours)"
OUTPUT_LINE_COUNT="$(echo -e "${OUTPUT}" | wc -l | awk '{print $1}')"
if [[ "${OUTPUT_LINE_COUNT}" -eq 1 ]]; then
  HOURS="$(echo -e "${OUTPUT}" | awk '{print $1}')"
else
  HOURS="$(echo -e "${OUTPUT}" | tail -n 1 | sed -e 's/ //g')"
fi

PREFIX="t:"

if [[ ! -z "${HOURS}" ]]; then
  TIME_HEADLINE="${PREFIX} ${HOURS}"
else
  TIME_HEADLINE="㏒ ⏳"
fi

CURRENT_TASK="$("${T}" cur)"

echo "${TIME_HEADLINE}"

if [[ ! -z "${CURRENT_TASK}" ]]; then
  echo "${CURRENT_TASK}"
fi

if [[ "$(date +%A)" == "Friday" ]]; then
  echo "w: $("${T}" week | tail -n 1 | sed -e 's/ //g')"
fi

echo "---"

echo -e "${OUTPUT}" | sed -e 's/\-/=/g'
