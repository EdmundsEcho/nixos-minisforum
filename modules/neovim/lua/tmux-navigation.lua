-- nvim-tmux-navigation-config.lua
-------------------------------------------------------------------------------
-- Seamless navigation between neovim windows and tmux panes
-- Works in two scenarios:
-- 1. Local tmux → SSH → Remote neovim (no remote tmux): basic vim navigation
-- 2. Remote tmux → Remote neovim: full tmux integration
-------------------------------------------------------------------------------

-- Check if we're inside tmux
local in_tmux = os.getenv("TMUX") ~= nil

if in_tmux then
    -- Use the plugin for tmux integration
    require("nvim-tmux-navigation").setup({
        disable_when_zoomed = true,
        keybindings = {
            left = "<C-h>",
            down = "<C-j>",
            up = "<C-k>",
            right = "<C-l>",
            last_active = "<C-\\>",
            next = "<C-Space>",
        },
    })
else
    -- Fallback to basic vim window navigation (when accessed via SSH without remote tmux)
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
end

-- Pane resizing (Alt + hjkl) - works in both scenarios
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
