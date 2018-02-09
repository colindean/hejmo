#!/usr/bin/env bash

# enable sshd
sudo systemsetup -f -setremotelogin on

# enable screen sharing but not with a vnc password, macs only
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -users admin -privs -all -restart -agent -menu


