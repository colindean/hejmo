#!/bin/bash

#props to @PaulSCoder and @joelmccracken for this wizardry

UPSEARCH_FOUND=0
UPSEARCH_NOT_FOUND=127

upsearch_cd () {
  # if we're at root and the file's not here, return not found
  # if the file is in the present working directory, echo the directory and return found
  # otherwise go up a directory and execute recursively
  # this could get slow if 'cd' is bound to something slow and not a simple changing of pwd
  test / == "$PWD" && test ! -e "$1" && return $UPSEARCH_NOT_FOUND || test -e "$1" && echo $PWD && return $UPSEARCH_FOUND || cd .. && upsearch_cd "$1"
}

upsearch () {
  (upsearch_cd "$1")
}
