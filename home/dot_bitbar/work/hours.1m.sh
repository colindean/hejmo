#!/usr/bin/env bash
# <xbar.title>Time checker</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>colindean</xbar.author>
# <xbar.author.github>colindean</xbar.author.github>
# <xbar.desc>
#   Runs `t hours` to show the current hours logged today
# </xbar.desc>

#Unfortunately, t requires basically everything.

export TERM=mac
PATH=/usr/local/bin:${PATH}
# shellcheck source=/dev/null
[[ -s "${HOME}/.env.local" ]] && source "${HOME}/.env.local"
T="${HOME}/.bin/t"


if [[ ! -f "${T}" ]]; then
  echo "⚠️  t"
  exit 1
fi

OUTPUT="$("${T}" hours)"

if ! "${T}" hours > /dev/null 2>&1; then
  echo "❌ t"
  echo "---"
  echo "Bad problem running ${T}. Write some debugging code."
fi

# shellcheck disable=SC2312
OUTPUT_LINE_COUNT="$(echo -e "${OUTPUT}" | wc -l | awk '{print $1}')"
if [[ "${OUTPUT_LINE_COUNT}" -eq 1 ]]; then
  HOURS="$(echo -e "${OUTPUT}" | awk '{print $1}')"
else
  # shellcheck disable=SC2312
  HOURS="$(echo -e "${OUTPUT}" | tail -n 1 | sed -e 's/ //g')"
fi

PREFIX="t:"

if [[ -n "${HOURS}" ]]; then
  TIME_HEADLINE="${PREFIX} ${HOURS}"
else
  TIME_HEADLINE="㏒ ⏳"
fi

CURRENT_TASK="$("${T}" cur)"

echo "${TIME_HEADLINE}"

if [[ -n "${CURRENT_TASK}" ]]; then
  echo "${CURRENT_TASK}"
fi

# shellcheck disable=SC2312
if [[ "$(date +%A)" == "Friday" ]]; then
  # shellcheck disable=SC2312
  echo "w: $("${T}" week | tail -n 1 | sed -e 's/ //g')"
fi

echo "---"

# shellcheck disable=SC2312
echo -e "${OUTPUT}" | sed -e 's/\-/=/g' | sed 's/$/| font=Courier/g'
