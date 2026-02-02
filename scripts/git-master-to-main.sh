#!/usr/bin/env bash

set -eu -o pipefail

FROM_BRANCH="${1:-master}"
TO_BRANCH="${2:-main}"
REMOTE="${3:-origin}"

>&2 echo "Renaming ${FROM_BRANCH} to ${TO_BRANCH}, fetching ${REMOTE}, and setting things straight…"
sleep 2
set -x
git branch -m "${FROM_BRANCH}" "${TO_BRANCH}"
git fetch "${REMOTE}"
if git ls-remote --exit-code --heads "${REMOTE}" "${TO_BRANCH}" >/dev/null 2>&1; then
  git branch -u "${REMOTE}/${TO_BRANCH}" "${TO_BRANCH}"
else
  >&2 echo "Remote branch ${REMOTE}/${TO_BRANCH} does not exist; skipping upstream configuration."
  >&2 echo "You can create it and set upstream with: git push -u ${REMOTE} ${TO_BRANCH}"
fi
if git ls-remote --heads "${REMOTE}" "${TO_BRANCH}" >/dev/null 2>&1; then
  git remote set-head "${REMOTE}" "${TO_BRANCH}"
fi
