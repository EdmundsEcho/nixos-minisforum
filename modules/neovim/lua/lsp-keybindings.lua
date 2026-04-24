-- lsp-keybindings.lua
-------------------------------------------------------------------------------
-- LSP keybindings and configuration
-- Attached when an LSP client connects via LspAttach autocommand
-- Migrated from local machine's lsp-handler.lua
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Diagnostic signs and virtual text
-------------------------------------------------------------------------------
vim.diagnostic.config({
  virtual_text = {
    prefix = "",
    spacing = 2,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘ ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "⚑ ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  update_in_insert = true,
  underline = false,
  severity_sort = false,
  float = {
      border = "rounded",
      source = true,
      header = "",
      prefix = "",
  },

})

-------------------------------------------------------------------------------
-- LspAttach autocommand
-------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Keybinding helper
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, {
        buffer = event.buf,
        noremap = true,
        silent = true,
        desc = "LSP: " .. desc,
      })
    end

    ---------------------------------------------------------------------------
    -- Navigation (using Telescope)
    ---------------------------------------------------------------------------
    -- Jump to definition (press <C-t> to jump back)
    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

    -- Goto Declaration (e.g., in C this goes to the header)
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    -- Find references for the word under cursor
    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

    -- Jump to implementation
    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

    -- Jump to type definition
    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

    ---------------------------------------------------------------------------
    -- Symbols
    ---------------------------------------------------------------------------
    -- Fuzzy find symbols in current document
    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

    -- Fuzzy find symbols in workspace
    map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    ---------------------------------------------------------------------------
    -- Actions
    ---------------------------------------------------------------------------
    -- Rename variable under cursor (across files)
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

    -- Execute code action
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    -- Hover documentation
    map("K", vim.lsp.buf.hover, "Hover Documentation")

    ---------------------------------------------------------------------------
    -- Document highlights
    -- Highlights references of word under cursor on CursorHold
    ---------------------------------------------------------------------------
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client.server_capabilities.documentHighlightProvider then
      local highlight_augroup =
        vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({
            group = highlight_augroup,
            buffer = event2.buf,
          })
        end,
      })
    end

    ---------------------------------------------------------------------------
    -- Inlay hints toggle
    ---------------------------------------------------------------------------
    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      map("<leader>tih", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, "[T]oggle [I]nlay [H]ints")
    end
  end,
})
