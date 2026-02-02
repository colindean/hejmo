#!/usr/bin/env bash

FROM_BRANCH="${1:-master}"
TO_BRANCH="${2:-main}"
REMOTE="${3:-origin}"

>&2 echo "Renaming ${FROM_BRANCH} to ${TO_BRANCH}, fetching ${REMOTE}, and setting things straight…"
sleep 2
set -x
git branch -m "${FROM_BRANCH}" "${TO_BRANCH}"
git fetch "${REMOTE}"
git branch -u "${REMOTE}"/"${TO_BRANCH}" "${TO_BRANCH}"
git remote set-head "${REMOTE}" -a
