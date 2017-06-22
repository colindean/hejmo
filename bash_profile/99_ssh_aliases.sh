
function goto-ayla {
  ssh -t admin@blackridge.dyn.cad.cx -L 5909:ayla.blackridge.cad.cx:5900 "echo -n 'Logging into ayla...' && ssh -t colin@ayla.blackridge.cad.cx"
}
function bank-of-colin {
  echo -n 'Logging into blackridge...'
  ssh -t admin@blackridge.dyn.cad.cx "echo -n 'Logging into ayla...' && ssh -t colin@ayla.blackridge.cad.cx 'echo Logged in and opening activity... && vi ~/Documents/Finance/Personal/$(date +%Y)/activity.ledger'"
}
