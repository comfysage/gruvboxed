---@class gruvboxed.types.StyleConfig
---@field tabline { reverse: boolean, color: gruvboxed.types.ColorField }
---@field search { reverse: boolean, inc_reverse: boolean }
---@field types { italic: boolean }
---@field keyword { italic: boolean }
---@field comment { italic: boolean }

---@class gruvboxed.types.Theme
---@field none gruvboxed.types.Color
---@field colors gruvboxed.types.Colors
---@field base { fg: gruvboxed.types.Color, bg: gruvboxed.types.Color }
---@field bg gruvboxed.types.Color
---@field fg gruvboxed.types.Color
---@field bg0 gruvboxed.types.Color
---@field bg1 gruvboxed.types.Color
---@field bg2 gruvboxed.types.Color
---@field bg3 gruvboxed.types.Color
---@field fg0 gruvboxed.types.Color
---@field fg1 gruvboxed.types.Color
---@field fg2 gruvboxed.types.Color
---@field red  gruvboxed.types.Color
---@field yellow gruvboxed.types.Color
---@field orange gruvboxed.types.Color
---@field green gruvboxed.types.Color
---@field aqua gruvboxed.types.Color
---@field blue gruvboxed.types.Color
---@field purple gruvboxed.types.Color
---@field dark table<gruvboxed.types.ColorField, gruvboxed.types.Color>
---@field syntax gruvboxed.types.Syntax
---@field diagnostic { ['ok'|'error'|'warn'|'info'|'hint']: gruvboxed.types.Color }
---@field diff { ['add'|'delete'|'change']: gruvboxed.types.Color }
---@field style gruvboxed.types.StyleConfig
---@field sign gruvboxed.types.Color
---@field comment gruvboxed.types.Color
---@field bg_accent gruvboxed.types.Color

---@class gruvboxed.types.Syntax
---@field keyword gruvboxed.types.Color
---@field object gruvboxed.types.Color
---@field field gruvboxed.types.Color
---@field type gruvboxed.types.Color
---@field context gruvboxed.types.Color
---@field constant gruvboxed.types.Color
---@field call gruvboxed.types.Color
---@field string gruvboxed.types.Color
---@field macro gruvboxed.types.Color
---@field annotation gruvboxed.types.Color

local M = {}

---@param colors gruvboxed.types.Colors
---@param config gruvboxed.types.Config
---@return gruvboxed.types.Theme
function M.setup(colors, config)
  local theme = {}

  theme.none = { 'NONE', 0 }
  theme.colors = colors

  theme.bg = theme.none
  theme.fg = colors.fg0
  if not config.transparent_background then
    theme.bg = colors.bg0
    if config.contrast_dark == 'hard' then
      theme.bg = colors.bg0_hard
      theme.fg = colors.fg0_hard
    end
    if config.contrast_dark == 'soft' then
      theme.bg = colors.bg0_soft
      theme.fg = colors.fg0_soft
    end
  end
  theme.base = { fg = colors.bg0, bg = theme.bg }

  theme.bg0 = colors.bg0
  theme.bg1 = colors.bg1
  theme.bg2 = colors.bg2
  theme.bg3 = colors.bg3

  theme.fg0 = colors.fg1
  theme.fg1 = colors.fg2
  theme.fg2 = colors.fg3
  theme.fg3 = colors.fg4

  local sign_colors = { soft = theme.bg3 }
  theme.sign = sign_colors[config.contrast_dark] or theme.none
  theme.comment = colors.bg4
  theme.bg_accent = theme.bg2

  theme.red = colors.red
  theme.orange = colors.orange
  theme.yellow = colors.yellow
  theme.green = colors.green
  theme.aqua = colors.aqua
  theme.blue = colors.blue
  theme.purple = colors.purple

  theme.syntax = {
    keyword = theme.red,
    object = theme.aqua,
    field = theme.aqua,
    type = theme.yellow,
    context = theme.orange,
    constant = theme.purple,
    call = theme.green,
    string = theme.green,
    macro = theme.orange,
    annotation = theme.orange,
  }
  theme.diagnostic = {
    ok = theme.green,
    error = theme.red,
    warn = theme.yellow,
    info = theme.aqua,
    hint = theme.blue,
  }
  theme.diff = {
    add = theme.green,
    delete = theme.red,
    change = theme.aqua,
  }

  theme.style = {
    search = { reverse = true },
  }
  theme.style = vim.tbl_deep_extend('force', theme.style, config.style)

  return theme
end

return M
