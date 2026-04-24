# plugins/lsp-keybindings.nix
#-------------------------------------------------------------------------------
# LSP keybindings - loaded on LspAttach
# Config in lua/lsp-keybindings.lua
#-------------------------------------------------------------------------------
{ lib, ... }:

{
  programs.nixvim.extraConfigLua = lib.mkAfter ''
    dofile(os.getenv("HOME") .. "/.hewnix-ext/lua/lsp-keybindings.lua")
  '';
}
