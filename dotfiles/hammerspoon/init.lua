-- @colindean's hammerspoon configuration

package.path = package.path .. ";" .. os.getenv("HOME") .. "/.hammerspoon/?.lua"

require "window_mgmt"

local anycomplete = require "anycomplete"
anycomplete.registerDefaultBindings()

local alert = require "hs.alert"
alert.show("🔨 ⏰")
