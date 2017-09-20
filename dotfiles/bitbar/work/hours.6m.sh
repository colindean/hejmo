#!/usr/bin/env bash
# <bitbar.title>Time checker</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>colindean</bitbar.author>
# <bitbar.author.github>colindean</bitbar.author.github>
# <bitbar.desc>
#   Runs `t hours` to show the current hours logged today
# </bitbar.desc>

#Unfortunately, t requires basically everything.

. "$HOME/.bash_profile"
T="$HOME/.bin/t"


if [[ ! -f "${T}" ]]; then
  echo "⚠️  t"
  exit 1
fi

OUTPUT="$("${T}" hours)"
HOURS="$(echo "${OUTPUT}" | tail -n 1 | sed -e 's/ //g')"

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

echo "---"

echo "${OUTPUT}" | sed -e 's/\-/=/g'
