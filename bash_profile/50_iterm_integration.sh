#!/usr/bin/env bash

# don't run if not in interactive mode
if ! (echo "${-}" | grep -q i); then
  return 0
fi

ITERM_INTEGRATION_SCRIPT="${HOME}/.iterm2_shell_integration.bash"

if [ -z "${NO_ITERM}" ] && [ -f "${ITERM_INTEGRATION_SCRIPT}" ] ; then
  # shellcheck source=~/.iterm2_shell_integration.bash
  . "${ITERM_INTEGRATION_SCRIPT}"
fi

disable-iterm-integration() {
  local OUTPUT=""
  IFS=';' read -ra CMDS <<< "${PROMPT_COMMAND}"
  for i in "${CMDS[@]}"; do
    if [[ ! "${i}" =~ "__bp" ]]; then
      OUTPUT="${OUTPUT};${i}"
    fi
  done

  export PROMPT_COMMAND="${OUTPUT}"
}

if [ -n "${SSH_CONNECTION}" ]; then
  echo "Connected via SSH, disabling iTerm integration." >&2
  disable-iterm-integration
fi
