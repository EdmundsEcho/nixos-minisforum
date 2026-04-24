-- nvim-tmux-navigation-config.lua
-------------------------------------------------------------------------------
-- Window navigation for remote neovim
-- C-hjkl are passed through from local tmux when in SSH
-------------------------------------------------------------------------------

-- Window navigation (Ctrl + hjkl)
vim.keymap.set("n", "<C-h>", "<C-w>h", {
    noremap = true,
    silent = true,
    desc = "Move to left window",
})
vim.keymap.set("n", "<C-j>", "<C-w>j", {
    noremap = true,
    silent = true,
    desc = "Move to window below",
})
vim.keymap.set("n", "<C-k>", "<C-w>k", {
    noremap = true,
    silent = true,
    desc = "Move to window above",
})
vim.keymap.set("n", "<C-l>", "<C-w>l", {
    noremap = true,
    silent = true,
    desc = "Move to right window",
})

-- Pane resizing (Alt + hjkl)
vim.keymap.set("n", "<M-j>", ":resize -2<CR>", {
    noremap = true,
    silent = true,
    desc = "Resize pane down",
})
vim.keymap.set("n", "<M-k>", ":resize +2<CR>", {
    noremap = true,
    silent = true,
    desc = "Resize pane up",
})
vim.keymap.set("n", "<M-h>", ":vertical resize -2<CR>", {
    noremap = true,
    silent = true,
    desc = "Resize pane left",
})
vim.keymap.set("n", "<M-l>", ":vertical resize +2<CR>", {
    noremap = true,
    silent = true,
    desc = "Resize pane right",
})

-- Split windows
vim.keymap.set("n", "<leader>-", ":sp<CR>", {
    noremap = true,
    silent = true,
    desc = "Horizontal split",
})
vim.keymap.set("n", "<leader>/", ":vsp<CR>", {
    noremap = true,
    silent = true,
    desc = "Vertical split",
})
vim.keymap.set("n", "<leader>\\", ":vsp<CR>", {
    noremap = true,
    silent = true,
    desc = "Vertical split",
})
