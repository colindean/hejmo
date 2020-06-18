-- @colindean's hammerspoon configuration

package.path = package.path .. ";" .. os.getenv("HOME") .. "/.hammerspoon/?.lua"

require "window_mgmt"
require "type"

local anycomplete = require "anycomplete"
anycomplete.registerDefaultBindings()

local hotkeyerr, hotkey = pcall(function() return require "hs.hotkey" end)
local alerterr, alert = pcall(function() return require "hs.alert" end)
mash = {"cmd", "alt", "ctrl"}

function toggle_zoom_mute()
  local zoom = hs.application.find("zoom.us")
  if not(zoom:findMenuItem("Unmute Audio")) then
    zoom:selectMenuItem("Mute Audio")
  elseif not(zoom:findMenuItem("Mute Audio")) then
    zoom:selectMenuItem("Unmute Audio")
  end
end

hotkey.bind(mash, "V", toggle_zoom_mute)

local alert = require "hs.alert"
alert.show("🔨 ⏰")


