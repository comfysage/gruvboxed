---@class gruvboxed.types.Color { [1]: string, [2]: number }

---@alias gruvboxed.types.ColorField 'bg0_hard'|'bg0_soft'|'bg0'|'bg1'|'bg2'|'bg3'|'bg4'|'bg5'|'bg_visual'|'bg_red'|'bg_green'|'bg_blue'|'bg_yellow'|'fg0_hard'|'fg0'|'fg0_soft'|'fg1'|'fg2'|'fg3'|'fg4'|'red'|'orange'|'yellow'|'green'|'aqua'|'blue'|'purple'
---@alias gruvboxed.types.Colors { [gruvboxed.types.ColorField]: gruvboxed.types.Color }

---@type gruvboxed.types.Colors
_G.gruvboxed_colors = {
  bg0_hard    = { '#1d2021', 234 },
  bg0         = { '#282828', 235 },
  bg0_soft    = { '#32302f', 236 },
  bg1         = { '#2a2a2a', 237 },
  bg2         = { '#3c3836', 239 },
  bg3         = { '#504945', 241 },
  bg4         = { '#665c54', 243 },
  bg5         = { '#928374', 245 },
  fg0_hard    = { '#f9f5d7', 230 },
  fg0         = { '#ffdbb3', 229 },
  fg0_soft    = { '#f2e5bc', 228 },
  fg1         = { '#f7cb9c', 223 },
  fg2         = { '#f7e2c1', 250 },
  fg3         = { '#f5cb9e', 248 },
  fg4         = { '#f0d3a8', 246 },
  red         = { '#f2594b', 167 },
  orange      = { '#fe8019', 208 },
  yellow      = { '#fabd2f', 214 },
  green       = { '#b0b846', 142 },
  aqua        = { '#8bba7f', 108 },
  blue        = { '#80aa9e', 109 },
  purple      = { '#d3869b', 175 },
}

_G.gruvboxed_colors_dark = {
  red    = { '#462726', 167 },
  green  = { '#363a25', 142 },
  yellow = { '#483b22', 214 },
  blue   = { '#2c3735', 109 },
  purple = { '#3e2f34', 175 },
  aqua   = { '#2e3a2e', 108 },
  orange = { '#492e21', 208 },
}

local M = {}

function M.colors()
  return _G.gruvboxed_colors
end

---@param config gruvboxed.types.Config?
---@return gruvboxed.types.Theme
function M.setup(config)
  ---@type gruvboxed.types.Config
  config = vim.tbl_extend('force', _G.gruvboxed_config, config or {})
  return require('gruvboxed.theme').setup(M.colors(), config)
end

return M
