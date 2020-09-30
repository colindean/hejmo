function trim() {
  local var=$@
  var="${var#"${var%%[![:space:]]*}"}"   # remove leading whitespace characters
  var="${var%"${var##*[![:space:]]}"}"   # remove trailing whitespace characters
  echo -n "$var"
}
function urldecode() {
  perl -pe 's/\%(\w\w)/chr hex $1/ge'
}

alias eo="eoconv --from=post-x --to=utf-8"

