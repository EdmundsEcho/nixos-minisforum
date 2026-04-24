-- conform-config.lua
-------------------------------------------------------------------------------
-- Formatting manager - conform.nvim
-- <leader>F to format
-- <leader>Fc to print active formatter
-- <leader>tf to toggle format-on-save
-------------------------------------------------------------------------------

local conform = require("conform")

-------------------------------------------------------------------------------
-- Helper: Find rustfmt config (project or global)
-------------------------------------------------------------------------------
local function get_rustfmt_config()
    local cwd = vim.fn.getcwd()
    local root = vim.fs.find("Cargo.toml", { upward = true, path = cwd })[1]
    if root then
        local project_dir = vim.fs.dirname(root)
        local local_cfg = project_dir .. "/.rustfmt.toml"
        if vim.uv.fs_stat(local_cfg) then return local_cfg end
    end
    return vim.fn.expand("~/.rustfmt.toml")
end

-------------------------------------------------------------------------------
-- Config file locations
-------------------------------------------------------------------------------
local stylua_cfg_file = vim.fn.expand("~/.stylua.toml")
local rust_cfg_file = get_rustfmt_config()
local taplo_cfg_file = vim.fn.expand("~/.taplo.toml")

-------------------------------------------------------------------------------
-- Helper: Report formatter info
-------------------------------------------------------------------------------
local function rpt(formatter)
    if type(formatter) ~= "table" then return "Invalid formatter data provided." end

    local report = (formatter.name or "No-name") .. "\n"
    report = report .. "Command: " .. (formatter.command or "N/A") .. "\n"
    report = report .. "CWD: " .. (formatter.cwd or "N/A") .. "\n"
    report = report .. "Available: " .. (formatter.available and "Yes" or "No") .. "\n"

    return report
end

-------------------------------------------------------------------------------
-- Format on save (respects toggle)
-------------------------------------------------------------------------------
local function format_on_save(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
    return {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    }
end

-------------------------------------------------------------------------------
-- Keybindings
-------------------------------------------------------------------------------
-- Format buffer
vim.keymap.set(
    { "n", "v" },
    "<leader>F",
    function()
        conform.format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 1000,
        })
    end,
    {
        desc = "[F]ormat buffer",
        noremap = true,
        silent = true,
    }
)

-- List active formatters
vim.keymap.set({ "n" }, "<leader>Fc", function()
    local formatters = conform.list_formatters()
    local msg = "Formatters:\n"
    for i, formatter in ipairs(formatters) do
        if type(formatter) == "table" then
            msg = msg .. rpt(formatter)
        else
            msg = msg .. tostring(formatter) .. "\n"
        end
        if i < #formatters then msg = msg .. "\n" end
    end
    vim.notify(msg, vim.log.levels.INFO)
end, {
    desc = "[F]ormat [c]onfig - current formatter",
    noremap = true,
    silent = true,
})

-- Toggle format on save
vim.keymap.set({ "n", "v" }, "<leader>tf", function()
    if vim.b.disable_autoformat then
        vim.cmd("FormatEnable")
        vim.notify("Format on save: enabled", vim.log.levels.INFO)
    else
        vim.cmd("FormatDisable!")
        vim.notify("Format on save: disabled", vim.log.levels.INFO)
    end
end, {
    desc = "[T]oggle on-off [F]ormat on save",
    noremap = true,
    silent = true,
})

-------------------------------------------------------------------------------
-- Commands: FormatDisable / FormatEnable
-------------------------------------------------------------------------------
vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
        vim.b.disable_autoformat = true
    else
        vim.g.disable_autoformat = true
    end
end, {
    desc = "Disable autoformat-on-save",
    bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
end, {
    desc = "Re-enable autoformat-on-save",
})

-------------------------------------------------------------------------------
-- Conform setup
-------------------------------------------------------------------------------
conform.setup({
    log_level = vim.log.levels.INFO,
    notify_on_error = true,
    format_on_save = format_on_save,

    formatters = {
        stylua = {
            prepend_args = { "--config-path", stylua_cfg_file },
        },
        taplo = {
            command = "taplo",
            args = { "fmt", "--config", taplo_cfg_file, "-" },
        },
        rustfmt = {
            command = "rustfmt",
            args = { "--config-path", rust_cfg_file },
        },
    },

    formatters_by_ft = {
        css = { "prettierd", "prettier", stop_after_first = true },
        fish = { "fish_indent" },
        graphql = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        json = { "jq" },
        lua = { "stylua" },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        python = { "ruff_format", "ruff_fix" },
        rust = {}, -- handled by rustacean
        toml = { "taplo" },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
    },
})
