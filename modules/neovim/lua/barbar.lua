-- barbar-config.lua
-------------------------------------------------------------------------------
-- Barbar - tabs at the top of the window
-------------------------------------------------------------------------------

require("barbar").setup({
    clickable = true,
    icons = {
        buffer_index = false,
        buffer_number = false,
        button = "×",
        separator = { left = "|", right = "" },
        inactive = { button = "×" },
        current = { buffer_index = true },
        visible = { modified = { buffer_number = false } },
        diagnostics = {
            [vim.diagnostic.severity.ERROR] = { enabled = true, icon = "ﬀ" },
            [vim.diagnostic.severity.WARN] = { enabled = false },
            [vim.diagnostic.severity.INFO] = { enabled = false },
            [vim.diagnostic.severity.HINT] = { enabled = true },
        },
    },
})

-- Buffer navigation: <leader>1-9 to go to buffer by index
local opts = { noremap = true, silent = true }
for i = 1, 9, 1 do
    vim.keymap.set("n", string.format("<leader>%d", i), string.format(":BufferGoto %d<CR>", i), opts)
end
