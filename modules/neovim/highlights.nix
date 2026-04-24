# highlights.nix
#-------------------------------------------------------------------------------
# All highlight applications
# Uses _G.C (colors) and _G.S (semantic) from colors.nix
#-------------------------------------------------------------------------------
{ lib, ... }:

{
  programs.nixvim.extraConfigLua = lib.mkAfter ''
    ---------------------------------------------------------------------------
    -- Apply all highlights
    ---------------------------------------------------------------------------
    local function apply_highlights()
      local C = _G.C
      local S = _G.S

      -------------------------------------------------------------------------
      -- Base Vim highlights
      -------------------------------------------------------------------------
      vim.api.nvim_set_hl(0, "Normal", { fg = S.Normal, bg = S.BgNone })
      vim.api.nvim_set_hl(0, "Comment", { fg = S.Comment, italic = true })
      vim.api.nvim_set_hl(0, "String", { fg = S.String, italic = true })
      vim.api.nvim_set_hl(0, "Constant", { fg = S.Constant })
      vim.api.nvim_set_hl(0, "Identifier", { fg = S.Identifier })
      vim.api.nvim_set_hl(0, "Function", { fg = S.Func })
      vim.api.nvim_set_hl(0, "Statement", { fg = S.Keyword })
      vim.api.nvim_set_hl(0, "PreProc", { fg = S.Keyword })
      vim.api.nvim_set_hl(0, "Keyword", { fg = S.Keyword })
      vim.api.nvim_set_hl(0, "Type", { fg = C.WhiteYellow })
      vim.api.nvim_set_hl(0, "Special", { fg = S.Dim })
      vim.api.nvim_set_hl(0, "Delimiter", { fg = S.Delimiter })
      vim.api.nvim_set_hl(0, "Operator", { fg = S.Delimiter })
      vim.api.nvim_set_hl(0, "Error", { fg = S.Error, bold = true })
      vim.api.nvim_set_hl(0, "Title", { fg = S.Title, bold = true })
      vim.api.nvim_set_hl(0, "Directory", { fg = S.Func })
      vim.api.nvim_set_hl(0, "Visual", { fg = S.Visual })

      -------------------------------------------------------------------------
      -- UI Elements
      -------------------------------------------------------------------------
      vim.api.nvim_set_hl(0, "LineNr", { fg = S.LineNr })
      vim.api.nvim_set_hl(0, "LineNrAbove", { fg = S.Dim })
      vim.api.nvim_set_hl(0, "LineNrBelow", { fg = S.Dim })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = S.BgDark })
      vim.api.nvim_set_hl(0, "StatusLine", { fg = S.StatusLine })
      vim.api.nvim_set_hl(0, "VertSplit", { fg = S.VertSplit, bg = S.BgDark })
      vim.api.nvim_set_hl(0, "MatchParen", { fg = S.Match, bg = S.MatchBg })
      vim.api.nvim_set_hl(0, "Search", { fg = S.Search, bg = S.SearchBg })
      vim.api.nvim_set_hl(0, "CurSearch", { fg = S.Search, bg = S.SearchBg })

      -- Diagnostics
      vim.api.nvim_set_hl(0, "DiagnosticError", { fg = S.Error })
      vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = S.Warning })
      vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = S.Info })
      vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = S.Hint })
      vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { fg = C.WhiteRed, italic = true })

      -- Notifications
      vim.api.nvim_set_hl(0, "NotifyBackground", { bg = C.White })

      -------------------------------------------------------------------------
      -- Popup Menu / Completion (Pmenu + nvim-cmp)
      -------------------------------------------------------------------------
      -- Base popup menu
      vim.api.nvim_set_hl(0, "Pmenu", { fg = S.Normal, bg = S.BgFloat })
      vim.api.nvim_set_hl(0, "PmenuSel", { bg = S.BgSelected })
      vim.api.nvim_set_hl(0, "PmenuSbar", { bg = S.BgSelected })
      vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#5c6370" })
      vim.api.nvim_set_hl(0, "PmenuKind", { fg = C.Magenta, bg = S.BgDarker })
      vim.api.nvim_set_hl(0, "PmenuKindSel", { fg = C.Magenta, bg = S.BgSelected })
      vim.api.nvim_set_hl(0, "PmenuExtra", { fg = C.LightBlue, bg = S.BgDarker })
      vim.api.nvim_set_hl(0, "PmenuExtraSel", { fg = C.LightBlue, bg = S.BgSelected })
      vim.api.nvim_set_hl(0, "PmenuIcon", { fg = C.CmpRed, bg = S.BgDarker })
      vim.api.nvim_set_hl(0, "PmenuIconSel", { fg = C.CmpRed, bg = S.BgSelected })

      -- Float windows
      vim.api.nvim_set_hl(0, "NormalFloat", { fg = S.Normal, bg = S.BgFloat })
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = C.LuciPrimaryDark, bg = S.BgFloat })

      -- nvim-cmp specific highlights
      vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = C.CmpGray, strikethrough = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = C.CmpBlue })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = C.CmpBlue })
      vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = C.CmpLightBlue })
      vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = C.CmpLightBlue })
      vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = C.CmpLightBlue })
      vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = C.CmpPink })
      vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = C.CmpPink })
      vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = C.CmpFront })
      vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = C.CmpFront })
      vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = C.CmpFront })

      -------------------------------------------------------------------------
      -- Neo-tree (file explorer)
      -------------------------------------------------------------------------
      vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = C.White, bg = C.LuciPrimaryDark })
      vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { fg = C.LuciPrimaryDark, bg = S.BgFloat })
      vim.api.nvim_set_hl(0, "NeoTreeFloatTitle", { fg = S.Normal, bg = S.BgFloat })
      vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = S.Normal, bg = S.BgNone })
      vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { fg = S.Normal, bg = S.BgNone })
      vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = S.BgDark, bg = S.BgNone })

      -------------------------------------------------------------------------
      -- Noice (command line / messages / notifications)
      -------------------------------------------------------------------------
      vim.api.nvim_set_hl(0, "NoiceMini", { fg = C.LuciPrimaryDark, bg = S.BgFloat })
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { fg = C.LuciSecondary, bg = S.BgFloat })
      vim.api.nvim_set_hl(0, "NoiceCmdlinePrompt", { fg = C.LuciSecondary, bg = S.BgFloat })
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = C.LuciPrimary, bg = S.BgFloat })
      vim.api.nvim_set_hl(0, "NoiceCmdlineIconCmdline", { fg = C.LuciPrimary, bg = S.BgFloat })

      -------------------------------------------------------------------------
      -- Barbar (buffer line)
      -------------------------------------------------------------------------
      vim.api.nvim_set_hl(0, "BufferCurrent", { fg = C.White, bg = C.Black, bold = true })
      vim.api.nvim_set_hl(0, "BufferCurrentMod", { fg = S.Accent, bg = C.Black })
      vim.api.nvim_set_hl(0, "BufferCurrentIndex", { fg = C.LuciSecondary, bg = C.Black, bold = true })
      vim.api.nvim_set_hl(0, "BufferCurrentSign", { fg = C.NearBlack, bg = C.NearBlack })

      vim.api.nvim_set_hl(0, "BufferVisible", { fg = C.White, bg = C.GrayCloud })
      vim.api.nvim_set_hl(0, "BufferVisibleMod", { fg = S.Accent, bg = C.GrayCloud })
      vim.api.nvim_set_hl(0, "BufferVisibleIndex", { fg = C.White, bg = C.GrayCloud })
      vim.api.nvim_set_hl(0, "BufferVisibleSign", { fg = C.NearBlack, bg = C.NearBlack })
      vim.api.nvim_set_hl(0, "BufferVisibleINFO", { fg = S.Dim, bg = C.NearBlack })
      vim.api.nvim_set_hl(0, "BufferVisibleERROR", { fg = S.Dim, bg = C.NearBlack })
      vim.api.nvim_set_hl(0, "BufferVisibleHINT", { fg = S.Dim, bg = C.NearBlack })

      vim.api.nvim_set_hl(0, "BufferInactive", { fg = S.Dim, bg = C.NearBlack })
      vim.api.nvim_set_hl(0, "BufferInactiveIndex", { fg = S.Dim, bg = C.NearBlack })
      vim.api.nvim_set_hl(0, "BufferInactiveMod", { fg = C.DimPink, bg = C.NearBlack })
      vim.api.nvim_set_hl(0, "BufferInactiveSign", { fg = C.NearBlack, bg = C.NearBlack })
      vim.api.nvim_set_hl(0, "BufferInactiveTarget", { fg = C.White, bg = C.NearBlack })

      vim.api.nvim_set_hl(0, "BufferScrollArrow", { fg = C.LuciSecondary })

      -------------------------------------------------------------------------
      -- Treesitter - General
      -------------------------------------------------------------------------
      -- Variables & Identifiers
      vim.api.nvim_set_hl(0, "@variable", { fg = S.Variable })
      vim.api.nvim_set_hl(0, "@variable.builtin", { fg = S.VariableBuiltin })
      vim.api.nvim_set_hl(0, "@property", { fg = S.Variable })
      vim.api.nvim_set_hl(0, "@field", { fg = S.Variable })
      vim.api.nvim_set_hl(0, "@parameter", { fg = S.Parameter })

      -- Functions
      vim.api.nvim_set_hl(0, "@function", { fg = S.Func })
      vim.api.nvim_set_hl(0, "@function.call", { fg = S.FuncCall })
      vim.api.nvim_set_hl(0, "@function.builtin", { fg = S.FuncBuiltin })
      vim.api.nvim_set_hl(0, "@function.macro", { fg = S.Macro })
      vim.api.nvim_set_hl(0, "@method", { fg = S.Func })
      vim.api.nvim_set_hl(0, "@method.call", { fg = S.FuncCall })
      vim.api.nvim_set_hl(0, "@constructor", { fg = S.VariableBuiltin })

      -- Types
      vim.api.nvim_set_hl(0, "@type", { fg = S.Type })
      vim.api.nvim_set_hl(0, "@type.builtin", { fg = S.TypeBuiltin })
      vim.api.nvim_set_hl(0, "@type.definition", { fg = S.TypeDef })
      vim.api.nvim_set_hl(0, "@attribute", { fg = S.Namespace })

      -- Keywords
      vim.api.nvim_set_hl(0, "@keyword", { fg = S.Keyword })
      vim.api.nvim_set_hl(0, "@keyword.import", { fg = S.Keyword })
      vim.api.nvim_set_hl(0, "@keyword.return", { fg = S.Keyword })
      vim.api.nvim_set_hl(0, "@keyword.function", { fg = S.Keyword })
      vim.api.nvim_set_hl(0, "@keyword.operator", { fg = S.Keyword })
      vim.api.nvim_set_hl(0, "@conditional", { fg = S.Keyword })
      vim.api.nvim_set_hl(0, "@repeat", { fg = S.Keyword })
      vim.api.nvim_set_hl(0, "@include", { fg = S.Keyword })

      -- Literals
      vim.api.nvim_set_hl(0, "@string", { fg = S.String, italic = true })
      vim.api.nvim_set_hl(0, "@string.documentation", { fg = S.Documentation })
      vim.api.nvim_set_hl(0, "@string.escape", { fg = S.ConstantLang })
      vim.api.nvim_set_hl(0, "@constant", { fg = S.Constant })
      vim.api.nvim_set_hl(0, "@constant.builtin", { fg = S.ConstantLang })
      vim.api.nvim_set_hl(0, "@number", { fg = S.Constant })
      vim.api.nvim_set_hl(0, "@boolean", { fg = S.Constant })

      -- Comments
      vim.api.nvim_set_hl(0, "@comment", { fg = S.Comment, italic = true })
      vim.api.nvim_set_hl(0, "@comment.documentation", { fg = S.Documentation })

      -- Punctuation
      vim.api.nvim_set_hl(0, "@punctuation", { fg = S.Delimiter })
      vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = S.Delimiter })
      vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = S.Delimiter })
      vim.api.nvim_set_hl(0, "@operator", { fg = S.Delimiter })

      -- Namespaces
      vim.api.nvim_set_hl(0, "@namespace", { fg = S.Namespace })
      vim.api.nvim_set_hl(0, "@module", { fg = S.Namespace })

      -------------------------------------------------------------------------
      -- Treesitter - Rust specific
      -------------------------------------------------------------------------
      vim.api.nvim_set_hl(0, "@comment.rust", { fg = S.Comment, italic = true })
      vim.api.nvim_set_hl(0, "@comment.documentation.rust", { fg = S.Documentation })
      vim.api.nvim_set_hl(0, "@constant.rust", { fg = S.ConstantLang })
      vim.api.nvim_set_hl(0, "@function.rust", { fg = S.Func })
      vim.api.nvim_set_hl(0, "@function.macro.rust", { fg = S.Macro })
      vim.api.nvim_set_hl(0, "@namespace.rust", { fg = C.MutedYellow })
      vim.api.nvim_set_hl(0, "@storageclass.lifetime.rust", { fg = S.Lifetime })

      -- Rust LSP semantic
      vim.api.nvim_set_hl(0, "@lsp.mod.attribute.rust", { fg = S.Namespace })
      vim.api.nvim_set_hl(0, "@lsp.mod.constant.rust", { fg = S.ConstantLang })
      vim.api.nvim_set_hl(0, "@lsp.type.lifetime.rust", { fg = S.Lifetime })
      vim.api.nvim_set_hl(0, "@lsp.type.builtinType.rust", { fg = S.TypeBuiltin })
      vim.api.nvim_set_hl(0, "@lsp.type.derive.rust", { fg = S.Trait })
      vim.api.nvim_set_hl(0, "@lsp.type.enumMember.rust", { fg = S.TypeBuiltin })
      vim.api.nvim_set_hl(0, "@lsp.type.interface.rust", { fg = S.Trait })
      vim.api.nvim_set_hl(0, "@lsp.type.macro.rust", { fg = S.Macro })
      vim.api.nvim_set_hl(0, "@lsp.type.namespace.rust", { fg = S.Namespace })
      vim.api.nvim_set_hl(0, "@lsp.type.typeAlias.rust", { fg = S.TypeAlias })
      vim.api.nvim_set_hl(0, "@lsp.type.unresolvedReference.rust", { fg = S.Error })
      vim.api.nvim_set_hl(0, "@lsp.typemod.namespace.declaration.rust", { fg = S.MyLib })
      vim.api.nvim_set_hl(0, "@lsp.typemod.method.trait.rust", { fg = S.Trait })
      vim.api.nvim_set_hl(0, "@lsp.type.method.rust", { fg = S.Variable })
      vim.api.nvim_set_hl(0, "@lsp.typemod.keyword.async.rust", { fg = S.Trait })

      -------------------------------------------------------------------------
      -- Treesitter - Python specific
      -------------------------------------------------------------------------
      vim.api.nvim_set_hl(0, "@constructor.python", { fg = S.VariableBuiltin })
      vim.api.nvim_set_hl(0, "@function.builtin.python", { fg = S.FuncBuiltin })
      vim.api.nvim_set_hl(0, "@variable.builtin.python", { fg = S.VariableBuiltin })
      vim.api.nvim_set_hl(0, "@string.documentation.python", { fg = S.Documentation })
      vim.api.nvim_set_hl(0, "@type.builtin.python", { fg = S.TypeBuiltin })
      vim.api.nvim_set_hl(0, "@type.python", { fg = S.TypeDef })
      vim.api.nvim_set_hl(0, "@function.python", { fg = S.Func })
      vim.api.nvim_set_hl(0, "@function.call.python", { fg = S.FuncCall })
      vim.api.nvim_set_hl(0, "@function.method.call.python", { fg = S.FuncMethod })

      -------------------------------------------------------------------------
      -- Treesitter - Lua specific
      -------------------------------------------------------------------------
      vim.api.nvim_set_hl(0, "@lsp.type.variable.lua", { fg = S.VariableBuiltin })

      -------------------------------------------------------------------------
      -- Treesitter - JavaScript/JSX specific
      -------------------------------------------------------------------------
      vim.api.nvim_set_hl(0, "@tag.javascript", { fg = S.Field })
      vim.api.nvim_set_hl(0, "@tag.builtin.javascript", { fg = S.TypeTag })
      vim.api.nvim_set_hl(0, "@comment.javascript", { fg = S.Comment, italic = true })
      vim.api.nvim_set_hl(0, "@comment.documentation.javascript", { fg = S.Documentation })
      vim.api.nvim_set_hl(0, "@tag.attribute.javascript", { fg = S.VariableBuiltin })
      vim.api.nvim_set_hl(0, "@constructor.javascript", { fg = S.ConstantLang })

      -- Legacy JSX syntax groups
      vim.api.nvim_set_hl(0, "jsxComponentName", { fg = S.ConstantLang })
      vim.api.nvim_set_hl(0, "jsxTag", { fg = C.Turquoise })
      vim.api.nvim_set_hl(0, "jsxTagName", { fg = C.Turquoise })
      vim.api.nvim_set_hl(0, "jsxCloseString", { fg = C.Lemon })
      vim.api.nvim_set_hl(0, "jsxCloseTag", { fg = C.Lemon })
      vim.api.nvim_set_hl(0, "jsxDot", { fg = S.Identifier })
      vim.api.nvim_set_hl(0, "jsxEqual", { fg = C.WhiteYellow })
      vim.api.nvim_set_hl(0, "jsxNameSpace", { fg = S.Error })
      vim.api.nvim_set_hl(0, "jsxString", { fg = S.String, italic = true })
      vim.api.nvim_set_hl(0, "jsxPunct", { fg = C.Lemon })
      vim.api.nvim_set_hl(0, "jsxClass", { fg = S.ConstantLang })
      vim.api.nvim_set_hl(0, "jsxCloseClass", { fg = S.ConstantLang })
      vim.api.nvim_set_hl(0, "xmlTagName", { fg = S.ConstantLang })
      vim.api.nvim_set_hl(0, "xmlEndTag", { fg = S.ConstantLang })
      vim.api.nvim_set_hl(0, "jsClassDefinition", { fg = S.ConstantLang })
      vim.api.nvim_set_hl(0, "jsObjectKey", { fg = S.Identifier })
      vim.api.nvim_set_hl(0, "xmlAttrib", { fg = C.LightPurple })

      -------------------------------------------------------------------------
      -- Todo comments
      -------------------------------------------------------------------------
      vim.api.nvim_set_hl(0, "TodoBgTODO", { bg = C.NearBlack })
    end

    -- Apply on VimEnter (after transparency autocmd)
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.schedule(apply_highlights)
      end,
    })

    -- Apply on ColorScheme changes
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.schedule(apply_highlights)
      end,
    })

    -- Apply immediately
    apply_highlights()
  '';
}
