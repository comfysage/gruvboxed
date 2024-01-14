local gruvboxed = {}

---@class gruvboxed.types.Config
---@field transparent_background boolean
---@field contrast_dark 'hard'|'medium'|'soft'
---@field override_terminal boolean
---@field style gruvboxed.types.StyleConfig
---@field overrides gruvboxed.types.HLGroups

---@type gruvboxed.types.Config
gruvboxed.default_config = {
    transparent_background = false,
    contrast_dark = 'medium',
    override_terminal = true,
    style = {
        tabline = { reverse = true, color = 'green' },
        search = { reverse = false, inc_reverse = true },
        types = { italic = true },
        keyword = { italic = true },
        comment = { italic = false },
    },
    overrides = {},
}

---@type gruvboxed.types.Config
_G.gruvboxed_config = vim.tbl_deep_extend("force", gruvboxed.default_config, _G.gruvboxed_config or {})

---@param config gruvboxed.types.Config|table
function gruvboxed.setup(config)
    _G.gruvboxed_config = vim.tbl_deep_extend("force", _G.gruvboxed_config, config or {})
end

---@param group string
---@param colors gruvboxed.types.ColorSpec
local function set_hi(group, colors)
    if not vim.tbl_isempty(colors) then
        ---@type vim.api.keyset.highlight
        local color = colors
        color.fg = colors[1] and colors[1][1] or 'NONE'
        color.bg = colors[2] and colors[2][1] or 'NONE'
        color.ctermfg = colors[1] and colors[1][2] or 'NONE'
        color.ctermbg = colors[2] and colors[2][2] or 'NONE'
        color[1] = nil
        color[2] = nil
        vim.api.nvim_set_hl(0, group, color)
    end
end

---@param hlgroups gruvboxed.types.HLGroups
local function set_highlights(hlgroups)
    vim.cmd("highlight Normal guifg=" .. hlgroups.Normal[1][1] .. " guibg=" .. hlgroups.Normal[2][1].. " ctermfg=" .. hlgroups.Normal[1][2] .. " ctermbg=" .. hlgroups.Normal[2][2])
    hlgroups.Normal = nil
    for group, colors in pairs(hlgroups) do
        set_hi(group, colors)
    end
end

function gruvboxed.load(_)
    if vim.g.colors_name then
        vim.cmd('hi clear')
    end

    vim.g.colors_name = 'gruvboxed'
    vim.o.termguicolors = true

    -- if vim.o.background == 'light' then
    --     _G.gruvboxed_config.theme = 'light'
    -- elseif vim.o.background == 'dark' then
    --     _G.gruvboxed_config.theme = 'default'
    -- end

    local theme = require 'gruvboxed.colors'.setup()
    local hlgroups = require 'gruvboxed.hl.init'.setup(theme, _G.gruvboxed_config)

    set_highlights(hlgroups)
end

function gruvboxed.colors()
    return require 'gruvboxed.colors'.colors()
end

return gruvboxed
