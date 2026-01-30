# @colindean's Hammerspoon configuration

[Hammerspoon](http://www.hammerspoon.org/) is a fantastic window management system for OS X.

## Briefly, how I use it

Hammerspoon enables you to write keybinding action configs in Lua. These actions are triggered using a mashing of meta keys plus a real key to activate. I use Hammerspoon primarily for window management on a 4x2 grid

I use `⌘^⌥` as my mash plus mostly vim keybindings to move windows around the display: `H` to move left, `L` to move right, `J` down, `K` up. I use multiple monitors often, so I've designated `N` for the next physical monitor, `P` for previous. `M` maximizes, `C` centers. `I` and `O` adjust width of a window, `Y` and `U` adjust height. `T` centers and shrinks to row 1, great for moving a window as close to the camera as it can get. `1`,`2`,`3` move a window to the left and make it take up that many columns on the 4x2 grid. `9`, `0`, `-` do the same but to the right. `;` snaps a window to the grid. `G` shows window position.

I may have added more. Look [approximately here](https://github.com/colindean/hejmo/blob/master/dotfiles/hammerspoon/window_mgmt.lua#L52) to see what exists these days.

## Installation

Get Hammerspoon from its website or do the following, which is much easier if you
have Homebrew installed (and you probably do if you're looking at this):

```shell
brew cask install hammerspoon
```

Then, symlink this directory to ~/.hammerspoon with something such as:

```shell
rm -rf ~/.hammerspoon; ln -s `pwd` ~/.hammerspoon
```

You're removing it because there's a pretty good chance that you started
Hammerspoon, and it created an empty directory for you. If you use the same management scripts from higher up in this repository, then you're already set: it'll be linked automatically when you run 'link_dotfiles.sh'.

You can then start up Hammerspoon and enjoy window management like I do. Read
through the `window_mgmt.lua` script to see what the hotkeys do. It's very
straightforward, especially if you've used Vim previously.

## History

Hammerspoon is a batteries-included version of [Mjolnir](http://mjolnir.io). I used Mjolnir and its many predecessors. My old [mjolnir-config](https://github.com/colindean/mjolnir-config) demonstrates the pedigree of the configuration in this repository as well as how much easier it is to set up Hammerspoon than Mjolnir.

Migrating from Mjolnir to Hammerspoon was a very quick task because of the abstractions I'd used in creating my configuration. It took about 20 minutes.
