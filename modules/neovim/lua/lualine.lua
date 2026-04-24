-- lualine-config.lua
-------------------------------------------------------------------------------
-- Lualine status line configuration
-- Colors reference _G.C from colors.nix
-------------------------------------------------------------------------------


---@diagnostic disable: undefined-global
---@diagnostic disable: undefined-field
local C = _G.C
---@diagnostic enable: undefined-field

-- Mode color function (for icon foreground)
local function get_mode_color()
    local mode = vim.fn.mode()
    local mode_colors = {
        n = C.BrightRed,
        i = C.SpringGreen,
        v = C.DarkBlue,
        [""] = C.DarkBlue,
        V = C.DarkBlue,
        c = C.Magenta,
        R = C.ReplaceRed,
        s = C.VisualPurple,
        S = C.VisualPurple,
        t = C.LuciSecondary,
    }
    return mode_colors[mode] or C.GrayCloud
end

-- Mode icon function
local function mode_icon()
    local icons = {
        n = "📗",
        i = "📙",
        v = "📘",
        [""] = "📘",
        V = "📘",
        c = "📕",
        R = "📕",
    }
    return icons[vim.fn.mode()] or "📓"
end

-- Search result function
local function search_result()
    if vim.v.hlsearch == 0 then
        return ""
    end
    local last_search = vim.fn.getreg("/")
    if not last_search or last_search == "" or last_search == "\\<filename\\>" then
        return ""
    end
    local searchcount = vim.fn.searchcount({ maxcount = 999 })
    if searchcount.current == 0 and searchcount.total == 0 then
        return ""
    end
    return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
end

-- LSP server name function
local function lsp_server_name()
    local msg = "No Lsp"
    local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
    local clients = vim.lsp.get_clients()
    if #clients == 0 then
        return msg
    end
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes or {}
        if vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
        end
    end
    return msg
end

-- Custom theme - SAME background for all modes
local section_bg = C.MaterialGray
local section_c_bg = C.MaterialBgAlt
local fg = C.BrightWhite

local uniform_theme = {
    normal = {
        a = { fg = fg, bg = section_bg, gui = "bold" },
        b = { fg = fg, bg = section_bg },
        c = { fg = fg, bg = section_c_bg },
    },
    insert = {
        a = { fg = fg, bg = section_bg, gui = "bold" },
        b = { fg = fg, bg = section_bg },
        c = { fg = fg, bg = section_c_bg },
    },
    visual = {
        a = { fg = fg, bg = section_bg, gui = "bold" },
        b = { fg = fg, bg = section_bg },
        c = { fg = fg, bg = section_c_bg },
    },
    replace = {
        a = { fg = fg, bg = section_bg, gui = "bold" },
        b = { fg = fg, bg = section_bg },
        c = { fg = fg, bg = section_c_bg },
    },
    command = {
        a = { fg = fg, bg = section_bg, gui = "bold" },
        b = { fg = fg, bg = section_bg },
        c = { fg = fg, bg = section_c_bg },
    },
    inactive = {
        a = { fg = fg, bg = C.MaterialBg, gui = "bold" },
        b = { fg = fg, bg = C.MaterialBg },
        c = { fg = fg, bg = C.MaterialBgAlt },
    },
}

-- Color variables for components
local fg_accent = C.Turquoise
local fg_text = C.WhiteYellow

require("lualine").setup({
    options = {
        component_separators = "",
        section_separators = "",
        theme = uniform_theme,
        globalstatus = true,
    },
    sections = {
        lualine_a = {
            {
                mode_icon,
                padding = { left = 1, right = 0 },
                color = function()
                    return { fg = get_mode_color() }
                end,
            },
        },
        lualine_b = {
            { "branch", color = { fg = fg_text } },
        },
        lualine_c = {
            {
                "filename",
                path = 1,
                shorting_target = 40,
                symbols = {
                    modified = "[+]",
                    readonly = "[-]",
                    unnamed = "[No Name]",
                },
                color = { fg = fg_text },
            },
        },
        lualine_x = {
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = {
                    error = " ",
                    warn = " ",
                    hint = " ",
                    info = " ",
                },
            },
            { "encoding", color = { fg = fg_text } },
            {
                "fileformat",
                symbols = {
                    unix = "",
                    dos = "",
                    mac = "",
                },
                color = { fg = fg_text },
            },
            { "filetype", color = { fg = fg_text } },
        },
        lualine_y = {
            { lsp_server_name, icon = " ",                color = { fg = fg_accent } },
            { search_result,   color = { fg = fg_text } },
            { "progress",      color = { fg = fg_accent } },
        },
        lualine_z = {
            { "location", color = { fg = fg_accent } },
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename" } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
})
