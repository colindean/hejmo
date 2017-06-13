-- @colindean's hammerspoon configuration
-- Window Management

-- Read through the script to see what it does. It's pretty clear based on
-- function name.

local griderr, grid  = pcall(function() return require "hs.grid" end)
local windowerr, window = pcall(function() return require "hs.window" end)
local hotkeyerr, hotkey = pcall(function() return require "hs.hotkey" end)
local alerterr, alert = pcall(function() return require "hs.alert" end)

function print_if_not_table(var)
  if not(type(var) == "table") then print(var) end
end

if not griderr or not windowerr or not hotkeyerr or not alerterr then
  hs.showerror("Some packages appear to be missing.")
  print("At least one package was missing. Have you installed the packages? See README.md.")
  print_if_not_table(grid)
  print_if_not_table(window)
  print_if_not_table(hotkey)
  print_if_not_table(alert)
end

mash = {"cmd", "alt", "ctrl"}

INITIAL_GRID_HEIGHT = 2
INITIAL_GRID_WIDTH = 4

function centerpoint()
  local current = grid.getGrid()
  return { x = 1, y = 0, w = current.w / 2, h = current.h }
end

function fullheightatleftwithwidth(width)
  return { x = 0, y = 0, w = width, h = grid.getGrid().h }
end
function fullheightatrightwithwidth(width)
  local current = grid.getGrid()
  return { x = current.w - width, y = 0, w = width, h = current.h }
end

function interp(s, tab)
  return (s:gsub('($%b{})', function(w) return tab[w:sub(3, -2)] or w end))
end

grid.setGrid(hs.geometry({w=INITIAL_GRID_WIDTH, h=INITIAL_GRID_HEIGHT}))

local grid_shortcuts = {
  [";"] = function() grid.snap(window.focusedWindow()) alert.show("╔═╦═╗\n   s  n \n╠═╬═╣\n   a  p \n╚═╩═╝") end,
  J = function() grid.pushWindowUp() alert.show("🔼") end,
  H = function() grid.pushWindowLeft() alert.show("◀️") end,
  L = function() grid.pushWindowRight() alert.show("▶️") end,
  K = function() grid.pushWindowDown() alert.show("🔽") end,
  I = function() grid.resizeWindowThinner() alert.show("⏩⏪") end,
  O = function() grid.resizeWindowWider() alert.show("⏪⏩") end,
  M = function() grid.maximizeWindow() alert.show("⏪⏫⏬⏩") end,
  C = function() grid.set(window.focusedWindow(), centerpoint(), window.focusedWindow():screen()) alert.show("↹") end,
  ["1"] = function() grid.set(window.focusedWindow(), fullheightatleftwithwidth(1), window.focusedWindow():screen()) alert.show("1") end,
  ["2"] = function() grid.set(window.focusedWindow(), fullheightatleftwithwidth(2), window.focusedWindow():screen()) alert.show("2") end,
  ["3"] = function() grid.set(window.focusedWindow(), fullheightatleftwithwidth(3), window.focusedWindow():screen()) alert.show("3") end,
  ["9"] = function() grid.set(window.focusedWindow(), fullheightatrightwithwidth(3), window.focusedWindow():screen()) alert.show("9") end,
  ["0"] = function() grid.set(window.focusedWindow(), fullheightatrightwithwidth(2), window.focusedWindow():screen()) alert.show("0") end,
  ["-"] = function() grid.set(window.focusedWindow(), fullheightatrightwithwidth(1), window.focusedWindow():screen()) alert.show("-") end,

  G = function()
        local point = grid.get(window.focusedWindow())
        alert.show(interp("⬌ ${x} ⬍ ${y}\n\t${w} × ${h}", point))
      end,
  Y = function() grid.resizeWindowTaller() alert.show("⏫⏬") end,
  U = function() grid.resizeWindowShorter() alert.show("⏬⏫") end,
  N = function() grid.set(window.focusedWindow(), centerpoint(), window.focusedWindow():screen():next()) alert.show("➡️") end,
  P = function() grid.set(window.focusedWindow(), centerpoint(), window.focusedWindow():screen():previous()) alert.show("⬅️") end,
}
print("If Hammerspoon console windows can be manipulated, but others cannot, "..
      "ensure that Hammerspoon is allowed in Accessibility preferences.")

for key, func in pairs(grid_shortcuts) do
  hotkey.bind(mash, key, func)
end
