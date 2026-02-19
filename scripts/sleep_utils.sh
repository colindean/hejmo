#!/usr/bin/env bash

sleepFor() {
  dots="…"
  count=$1
  while [[ "${count}" -ge 1 ]]; do
    echo -n "${count}${dots}"
    sleep 1
    (( count-- ))
  done
  echo '0!'
}
