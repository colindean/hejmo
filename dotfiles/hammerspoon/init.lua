-- @colindean's hammerspoon configuration

package.path = package.path .. ";" .. os.getenv("HOME") .. "/.hammerspoon/?.lua"

require "window_mgmt"

local alert = require "hs.alert"
alert.show("🔨 ⏰")
