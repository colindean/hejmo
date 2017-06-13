# @colindean's Hammerspoon configuration

[Hammerspoon](http://www.hammerspoon.org/) is a fantastic window management system for OS X.

Get Hammerspoon from its website or do the following, which is much easier if you
have Homebrew installed (and you probably do if you're looking at this):

    brew cask install hammerspoon

Then, symlink this directory to ~/.hammerspoon with something such as:

    rm -rf ~/.hammerspoon; ln -s `pwd` ~/.hammerspoon

You're removing it because there's a pretty good chance that you started
Hammerspoon, and it created an empty directory for you. If you use the same management scripts from higher up in this repository, then you're already set: it'll be linked automatically when you run 'link_dotfiles.sh'.

You can then start up Hammerspoon and enjoy window management like I do. Read
through the `window_mgmt.lua` script to see what the hotkeys do. It's very
straightforward, especially if you've used Vim previously.

## History

Hammerspoon is a batteries-included version of [Mjolnir](http://mjolnir.io). I used Mjolnir and its many predecessors. My old [mjolnir-config](https://github.com/colindean/mjolnir-config) demonstrates the pedigree of the configuration in this repository as well as how much easier it is to set up Hammerspoon than Mjolnir.

Migrating from Mjolnir to Hammerspoon was a very quick task because of the abstractions I'd used in creating my configuration. It took about 20 minutes.
