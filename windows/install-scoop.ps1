# allow execution after retrieval
set-executionpolicy remotesigned -s currentuser
# get the installer and execute it
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
# Scoop will use Aria2 for retrieval if it's available. It's a lot faster than built-in stuff!
scoop install aria2 
