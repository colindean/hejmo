-- quick shortcuts for typing common things

local eventtaperr, eventtap  = pcall(function() return require "hs.eventtap" end)
local hotkeyerr, hotkey = pcall(function() return require "hs.hotkey" end)
local alerterr, alert = pcall(function() return require "hs.alert" end)

function print_if_not_table(var)
  if not(type(var) == "table") then print(var) end
end

if not eventtaperr or not hotkeyerr or not alerterr then
  hs.showerror("Some packages appear to be missing")
  print_if_not_table(eventtap)
end

mash = {"cmd","alt","ctrl"}

function getUserName()
  return os.getenv("USER")
end

local type_shortcuts = {
  Z = function() eventtap.keyStrokes(getUserName()) alert.show("Typed [" .. getUserName() .. "] into current input") end
}

for key, func in pairs(type_shortcuts) do
  hotkey.bind(mash, key, func)
end
