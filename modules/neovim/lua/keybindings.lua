-- keybindings.lua
-------------------------------------------------------------------------------
-- Core keybindings for neovim
-- Migrated from local machine configuration
-------------------------------------------------------------------------------
---@diagnostic disable: undefined-field

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-------------------------------------------------------------------------------
-- Escape mappings
-------------------------------------------------------------------------------
map("i", "df", "<ESC>l", { noremap = true, silent = true, desc = "Exit insert mode" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-------------------------------------------------------------------------------
-- Save file
-------------------------------------------------------------------------------
map({ "n", "v" }, "<C-a>", ":w<CR>", opts)
map("i", "<C-a>", "<Esc>:w<CR>", opts)
map("n", "<leader>w", "<cmd>w<CR>", { noremap = true, silent = true, desc = "Save file" })

-------------------------------------------------------------------------------
-- Open nvim config
-------------------------------------------------------------------------------
map("n", "<leader>cfg", ":e ~/.hewnix-ext/<CR>", { noremap = true, silent = true, desc = "Open nvim config" })

-------------------------------------------------------------------------------
-- Execute files/lines
-------------------------------------------------------------------------------
map("n", "<leader><leader>l", "<cmd>.lua<CR>", { desc = "Execute the current [l]ine" })
map("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "E[x]ecute the current file" })

-------------------------------------------------------------------------------
-- Buffer management (barbar)
-------------------------------------------------------------------------------
-- Buffer navigation by index
for i = 1, 9, 1 do
    map("n", string.format("<leader>%d", i), string.format(":BufferGoto %d<CR>", i), opts)
end

-- Close buffer
map("n", "<leader>x", "<cmd>BufferClose<CR>", { noremap = true, silent = true, desc = "Close buffer" })

-- Close buffer without closing window
map("n", "<leader>bd", "<cmd>BufferClose<CR>", {
    noremap = true,
    silent = true,
    desc = "[B]uffer [D]elete",
})

-- Next/previous buffer
map("n", "<S-h>", "<cmd>BufferPrevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>BufferNext<CR>", { noremap = true, silent = true, desc = "Next buffer" })

-- List buffers
map("n", "<leader>bb", "<CMD>buffers<CR><CMD>buffer<Space>", {
    noremap = true,
    silent = true,
    desc = "List and jump to buffer",
})

-------------------------------------------------------------------------------
-- Quit commands
-------------------------------------------------------------------------------
map("n", "<leader>q", "<cmd>q<CR>", { noremap = true, silent = true, desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { noremap = true, silent = true, desc = "Force quit all" })

-------------------------------------------------------------------------------
-- Window navigation
-- NOTE: C-hjkl handled in nvim-tmux-navigation-config.lua
-- (supports both direct SSH and remote tmux scenarios)
-------------------------------------------------------------------------------
map("n", "<BS>", "<C-w>h", { noremap = true, silent = true, desc = "Fix for C-h" })

-------------------------------------------------------------------------------
-- Window resizing
-------------------------------------------------------------------------------
map("n", "<C-Up>", "<cmd>resize +2<CR>", { noremap = true, silent = true, desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { noremap = true, silent = true, desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { noremap = true, silent = true, desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { noremap = true, silent = true, desc = "Increase window width" })

-------------------------------------------------------------------------------
-- Zoom pane
-------------------------------------------------------------------------------
map("n", "<leader>z", ":wincmd _<CR>:wincmd \\|<CR>", { noremap = true, silent = true, desc = "[Z]oom vim pane" })
map("n", "<leader>Z", ":wincmd =<CR>", { noremap = true, silent = true, desc = "Rebalance vim panes" })

-------------------------------------------------------------------------------
-- Split management
-------------------------------------------------------------------------------
map("n", "<leader>sv", "<cmd>vsplit<CR>", { noremap = true, silent = true, desc = "Vertical split" })
map("n", "<leader>-", ":sp<CR>", { noremap = true, silent = true, desc = "Horizontal split" })
map("n", "<leader>/", ":vsp<CR>", { noremap = true, silent = true, desc = "Vertical split" })
map("n", "<leader>\\", ":vsp<CR>", { noremap = true, silent = true, desc = "Vertical split" })
map("n", "<leader>se", "<C-w>=", { noremap = true, silent = true, desc = "Equal split sizes" })
map("n", "<leader>sx", "<cmd>close<CR>", { noremap = true, silent = true, desc = "Close split" })

-------------------------------------------------------------------------------
-- Line navigation
-------------------------------------------------------------------------------
map("n", "gg", ":0<CR>", { noremap = true, silent = true, desc = "Go to top of buffer" })
map("n", "G", "G0", { noremap = true, silent = true, desc = "Go to end of buffer" })
map("n", "j", "gj", { noremap = true, silent = true, desc = "Move down by screen line" })
map("n", "k", "gk", { noremap = true, silent = true, desc = "Move up by screen line" })

-------------------------------------------------------------------------------
-- Centering after jumps
-------------------------------------------------------------------------------
map("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true, desc = "Page down and center" })
map("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true, desc = "Page up and center" })
map("n", "n", "nzzzv", { noremap = true, silent = true, desc = "Next search and center" })
map("n", "N", "Nzzzv", { noremap = true, silent = true, desc = "Prev search and center" })

-------------------------------------------------------------------------------
-- Join lines without moving cursor
-------------------------------------------------------------------------------
map("n", "J", "mzJ`z", { noremap = true, silent = true, desc = "Join lines (keep cursor)" })

-------------------------------------------------------------------------------
-- Insert line without entering insert mode
-------------------------------------------------------------------------------
map("n", "<Enter>", "O<esc>j", { noremap = true, silent = true, desc = "Insert line above" })
map("n", "[<space>", ":call append(line('.')-1,'')<CR><ESC>da", {
    noremap = true,
    silent = true,
    desc = "Insert empty line above cursor",
})

-------------------------------------------------------------------------------
-- Insert mode shortcuts
-------------------------------------------------------------------------------
map("i", "<C-_>", "-><space>", { noremap = true, silent = true, desc = "Insert ->" })
map("i", "<C-l>", "<Esc>A;", { noremap = true, silent = true, desc = "Jump to end of line and insert ;" })
map("i", "<C-b>", "<Esc>ui", { noremap = true, silent = true, desc = "Undo from insert mode" })
map("i", "<C-p>", "<C-r>*", { noremap = true, silent = true, desc = "Paste from clipboard in insert mode" })

-------------------------------------------------------------------------------
-- Normal mode insert helpers
-------------------------------------------------------------------------------
map("n", "<leader>;", "mzA;<Esc>`z", { noremap = true, silent = true, desc = "Insert ';' at end of line" })

-------------------------------------------------------------------------------
-- Better indenting in visual mode
-------------------------------------------------------------------------------
map("v", "<", "<gv", { noremap = true, silent = true, desc = "Indent left and reselect" })
map("v", ">", ">gv", { noremap = true, silent = true, desc = "Indent right and reselect" })

-------------------------------------------------------------------------------
-- Move lines up/down in visual mode
-------------------------------------------------------------------------------
map("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection up" })

-------------------------------------------------------------------------------
-- Copy/Paste
-------------------------------------------------------------------------------
map("n", "<leader>y", '"*y', { noremap = true, silent = true, desc = "[Y]ank to OS clipboard" })
map("v", "<leader>y", '"*y', { noremap = true, silent = true, desc = "[Y]ank to OS clipboard" })
map("n", "<leader>p", '"*p', { noremap = true, silent = true, desc = "[P]aste from OS clipboard" })
map("v", "<leader>p", '"*p', { noremap = true, silent = true, desc = "[P]aste from OS clipboard" })
map("x", "<leader>P", '"_dP', { noremap = true, silent = true, desc = "Paste without losing register" })

-------------------------------------------------------------------------------
-- Delete to black hole register
-------------------------------------------------------------------------------
map({ "n", "v" }, "<leader>D", '"_d', { noremap = true, silent = true, desc = "Delete to black hole" })

-------------------------------------------------------------------------------
-- Select all
-------------------------------------------------------------------------------
map("n", "<leader>aa", "ggVG", { noremap = true, silent = true, desc = "Select all text in buffer" })

-------------------------------------------------------------------------------
-- File operations
-------------------------------------------------------------------------------
map("n", "<leader>fn", ':let @*=expand("%")<CR>', {
    noremap = true,
    silent = true,
    desc = "[F]ile - Copy file [N]ame",
})
map("n", "<leader>fp", ':let @*=expand("%:p")<CR>', {
    noremap = true,
    silent = true,
    desc = "[F]ile - Copy file [P]ath",
})
map("n", "<leader>fo", ":e <C-R>=expand(\"%:p:h\") . '/'<CR>", {
    noremap = true,
    silent = true,
    desc = "[F]ile - [O]pen file prompt with current path",
})

-------------------------------------------------------------------------------
-- Change local working directory
-------------------------------------------------------------------------------
map("n", "<leader>cd", ":lcd %:p:h<CR>:pwd<CR>", {
    noremap = true,
    silent = true,
    desc = "[C]hange local working [D]irectory",
})

-------------------------------------------------------------------------------
-- Command mode helpers
-------------------------------------------------------------------------------
map("n", "<leader>m", ":%s/", { noremap = true, desc = "Start search and replace" })
map("n", "<leader>v", ":@:<CR>", { noremap = true, silent = true, desc = "Execute last command" })

-------------------------------------------------------------------------------
-- Disable Ex mode
-------------------------------------------------------------------------------
map("n", "Q", "<nop>", { noremap = true, silent = true, desc = "Disable Ex mode" })

-------------------------------------------------------------------------------
-- Quickfix navigation
-------------------------------------------------------------------------------
map("n", "<leader>co", "<cmd>copen<CR>", { noremap = true, silent = true, desc = "Open quickfix" })
map("n", "<leader>cc", "<cmd>cclose<CR>", { noremap = true, silent = true, desc = "Close quickfix" })
map("n", "[q", "<cmd>cprev<CR>zz", { noremap = true, silent = true, desc = "Previous quickfix" })
map("n", "]q", "<cmd>cnext<CR>zz", { noremap = true, silent = true, desc = "Next quickfix" })

-------------------------------------------------------------------------------
-- Location list navigation
-------------------------------------------------------------------------------
map("n", "[l", "<cmd>lprev<CR>zz", { noremap = true, silent = true, desc = "Previous location" })
map("n", "]l", "<cmd>lnext<CR>zz", { noremap = true, silent = true, desc = "Next location" })

-------------------------------------------------------------------------------
-- Diagnostic navigation
-------------------------------------------------------------------------------
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true, desc = "Previous diagnostic" })
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true, desc = "Next diagnostic" })
map("n", "<leader>k", vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "Previous diagnostic" })
map("n", "<leader>j", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Next diagnostic" })
map("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>",
    { noremap = true, silent = true, desc = "Show diagnostic" })

-------------------------------------------------------------------------------
-- Operator-pending maps
-------------------------------------------------------------------------------
map("o", "p", "i(", { noremap = true, silent = true, desc = "Inside parentheses" })
map("o", "b", "i[", { noremap = true, silent = true, desc = "Inside brackets" })
map("o", "np", ":<c-u>normal! f(lvi(<cr>", { noremap = true, silent = true, desc = "Next parentheses" })
map("o", "nb", ":<c-u>normal! f[lvi[<cr>", { noremap = true, silent = true, desc = "Next brackets" })
map("o", "pp", ":<c-u>normal! F(lvi(<cr>", { noremap = true, silent = true, desc = "Previous parentheses" })
map("o", "pb", ":<c-u>normal! F[lvi[<cr>", { noremap = true, silent = true, desc = "Previous brackets" })

-------------------------------------------------------------------------------
-- Tab management
-------------------------------------------------------------------------------
map("n", "<leader>tn", "<cmd>tabnew<CR>", { noremap = true, silent = true, desc = "New tab" })
map("n", "<leader>tc", "<cmd>tabclose<CR>", { noremap = true, silent = true, desc = "Close tab" })
map("n", "]t", "<cmd>tabnext<CR>", { noremap = true, silent = true, desc = "Next tab" })
map("n", "[t", "<cmd>tabprev<CR>", { noremap = true, silent = true, desc = "Previous tab" })

-------------------------------------------------------------------------------
-- Visual search
-------------------------------------------------------------------------------
map("v", "*", ':call VisualSelection("f", "")<CR>', {
    noremap = true,
    silent = true,
    desc = "Search for selection forward",
})
map("v", "#", ':call VisualSelection("b", "")<CR>', {
    noremap = true,
    silent = true,
    desc = "Search for selection backward",
})

-------------------------------------------------------------------------------
-- Return to last edit position when opening files
-------------------------------------------------------------------------------
vim.api.nvim_create_augroup("last_edit", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
    group = "last_edit",
    callback = function()
        local line = vim.fn.line
        if line("'\"") > 0 and line("'\"") <= line("$") then
            vim.cmd('normal! g`"')
        end
    end,
    desc = "Return to last edit position when opening files",
})

-------------------------------------------------------------------------------
-- Diagnostic formatting
-------------------------------------------------------------------------------
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    update_in_insert = false,
    virtual_text = true,
})

-- Remember info about open buffers on close
vim.opt.viminfo:append("%")
