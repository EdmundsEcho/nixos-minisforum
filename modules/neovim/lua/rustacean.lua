-- rustacean-config.lua
-------------------------------------------------------------------------------
-- Rustacean.nvim - Enhanced Rust development
-- Includes lsp-file-operations capabilities for neo-tree integration
-------------------------------------------------------------------------------
---@diagnostic disable: undefined-field

-- Get lsp-file-operations capabilities
local lsp_file_ops_ok, lsp_file_operations = pcall(require, "lsp-file-operations")
local file_ops_capabilities = {}
if lsp_file_ops_ok then
    file_ops_capabilities = lsp_file_operations.default_capabilities()
end

-- Merge with default capabilities
local default_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = vim.tbl_deep_extend("force", default_capabilities, file_ops_capabilities)

-- Configure rustacean
vim.g.rustaceanvim = {
    tools = {
        hover_actions = {
            auto_focus = true,
        },
    },
    server = {
        capabilities = capabilities,
        default_settings = {
            ["rust-analyzer"] = {
                checkOnSave = true,
                check = {
                    command = "clippy",
                },
                procMacro = {
                    enable = true,
                },
                cargo = {
                    loadOutDirsFromCheck = true,
                    buildScripts = {
                        enable = true,
                    },
                    extraEnv = {
                        CARGO_TARGET_DIR = "target/rust-analyzer",
                    },
                },
            },
        },
    },
    dap = {},
}

-- Rust-specific keybindings (only active in rust files)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, silent = true }

        -- Rustacean-specific commands
        vim.keymap.set("n", "<leader>rc", "<cmd>RustLsp openCargo<CR>",
            vim.tbl_extend("force", opts, { desc = "[R]ust open [C]argo.toml" }))
        vim.keymap.set("n", "<leader>rr", "<cmd>RustLsp runnables<CR>",
            vim.tbl_extend("force", opts, { desc = "[R]ust [R]unnables" }))
        vim.keymap.set("n", "<leader>rd", "<cmd>RustLsp debuggables<CR>",
            vim.tbl_extend("force", opts, { desc = "[R]ust [D]ebuggables" }))
        vim.keymap.set("n", "<leader>re", "<cmd>RustLsp expandMacro<CR>",
            vim.tbl_extend("force", opts, { desc = "[R]ust [E]xpand macro" }))
        vim.keymap.set("n", "<leader>rp", "<cmd>RustLsp rebuildProcMacros<CR>",
            vim.tbl_extend("force", opts, { desc = "[R]ust rebuild [P]roc macros" }))
        vim.keymap.set("n", "<leader>rm", "<cmd>RustLsp parentModule<CR>",
            vim.tbl_extend("force", opts, { desc = "[R]ust parent [M]odule" }))
        vim.keymap.set("n", "<leader>rj", "<cmd>RustLsp joinLines<CR>",
            vim.tbl_extend("force", opts, { desc = "[R]ust [J]oin lines" }))
        vim.keymap.set("n", "K", "<cmd>RustLsp hover actions<CR>",
            vim.tbl_extend("force", opts, { desc = "Rust hover actions" }))
        vim.keymap.set("n", "<leader>ra", "<cmd>RustLsp codeAction<CR>",
            vim.tbl_extend("force", opts, { desc = "[R]ust code [A]ction" }))
    end,
})
