-- neo-tree-config.lua
-------------------------------------------------------------------------------
-- Neo-tree file explorer configuration
-------------------------------------------------------------------------------

-- Window picker setup
require("window-picker").setup({
    hint = "floating-big-letter",
    filter_rules = {
        include_current_win = false,
        autoselect_one = true,
        bo = {
            filetype = { "neo-tree", "neo-tree-popup", "notify" },
            buftype = { "terminal", "quickfix" },
        },
    },
})

-- LSP file operations setup
local ok, lsp_file_ops = pcall(require, "lsp-file-operations")
if ok then lsp_file_ops.setup() end

-- Neo-tree setup
require("neo-tree").setup({
    log_level = "info",

    bind_to_cwd = false, -- two-way sync with vim cwd

    open_files_do_not_replace_types = { "terminal", "trouble", "qf" },

    window = {
        position = "left",
        width = 40,
        mappings = {
            ["<cr>"] = "open",
            ["o"] = "open",
            ["s"] = "open_split",
            ["v"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["."] = "set_root",
            ["cd"] = "set_root",
            ["<bs>"] = "navigate_up",
            ["u"] = "navigate_up",
        },
    },

    filesystem = {
        filtered_items = {
            visible = true,
            show_hidden_count = true,
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_by_name = {
                ".git",
                ".DS_Store",
            },
            never_show = {},
        },
        follow_current_file = {
            enabled = true,
            leave_dirs_open = true,
        },
    },

    buffers = {
        bind_to_cwd = false,
        follow_current_file = {
            enabled = true, -- find and focus the file in active buffer
        },
    },
})

-- Keybindings remain the same
vim.keymap.set("n", "<leader>te", "<cmd>Neotree reveal toggle<CR>", {
    noremap = true,
    silent = true,
    desc = "[T]oggle file [E]xplorer",
})
vim.keymap.set("n", "<leader>tf", "<cmd>Neotree reveal<CR>", {
    noremap = true,
    silent = true,
    desc = "Reveal [F]ile in explorer",
})
vim.keymap.set("n", "<leader>tg", "<cmd>Neotree git_status<CR>", {
    noremap = true,
    silent = true,
    desc = "[G]it status in explorer",
})
vim.keymap.set("n", "<leader>tb", "<cmd>Neotree buffers<CR>", {
    noremap = true,
    silent = true,
    desc = "[B]uffers in explorer",
})
