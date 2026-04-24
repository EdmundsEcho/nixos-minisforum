-- options.lua
-------------------------------------------------------------------------------
-- Core neovim options and settings
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- working directory changes with buffer
-------------------------------------------------------------------------------
vim.opt.autochdir = false

-------------------------------------------------------------------------------
-- Cursor wrapping - move to end of previous line / start of next line
-------------------------------------------------------------------------------
vim.opt.whichwrap:append("h,l,<,>,[,]")

-------------------------------------------------------------------------------
-- Jumplist persistence
-------------------------------------------------------------------------------
vim.opt.jumpoptions = "stack"
vim.opt.shada = "'1000,f1,<500,:100,/100,h"

-------------------------------------------------------------------------------
-- OSC 52 clipboard for remote/headless use
-------------------------------------------------------------------------------
vim.g.clipboard = {
    name = "OSC 52",
    copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
        ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
        ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
}

-- Now that OSC 52 is set, enable unnamedplus
vim.opt.clipboard = "unnamedplus"

-------------------------------------------------------------------------------
-- Undo persistence
-------------------------------------------------------------------------------
local undodir = vim.fn.expand("~/.vimdid")
if vim.fn.isdirectory(undodir) == 0 then vim.fn.mkdir(undodir, "p") end
vim.opt.undodir = undodir

-------------------------------------------------------------------------------
-- Ripgrep integration
-------------------------------------------------------------------------------
if vim.fn.executable("rg") == 1 then
    vim.o.grepprg = "rg --vimgrep --smart-case --hidden"
    vim.o.grepformat = "%f:%l:%c:%m"
end

-------------------------------------------------------------------------------
-- Smart 0 - go to first non-blank or column 0
-------------------------------------------------------------------------------
local function go_to_front_line()
    local col_cursor = vim.fn.col(".")
    local row_cursor = vim.fn.line(".")
    local col_front = vim.fn.indent(vim.fn.line("."))
    if col_cursor ~= (1 + col_front) then
        vim.fn.cursor(row_cursor, col_front + 1)
    else
        vim.fn.cursor(row_cursor, 1)
    end
end
vim.keymap.set(
    "n",
    "0",
    go_to_front_line,
    { noremap = true, silent = true, desc = "Smart line beginning" }
)

-------------------------------------------------------------------------------
-- Diagnostic configuration
-------------------------------------------------------------------------------
-- See lsp-keybindings.lua
