# plugins/neo-tree.nix
#-------------------------------------------------------------------------------
# Neo-tree file explorer configuration
# Config in lua/neo-tree-config.lua
#-------------------------------------------------------------------------------
{ lib, pkgs, ... }:

{
  # Add companion plugins
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    nvim-lsp-file-operations
    nvim-window-picker
  ];

  # Enable neo-tree. The actual config is loaded from
  # ~/.hewnix-ext/lua/neo-tree.lua via extraConfigLua below; we just need
  # the plugin available. (`settings` was removed in nixvim 25.05.)
  programs.nixvim.plugins.neo-tree.enable = true;

  # Load our config
  programs.nixvim.extraConfigLua = lib.mkAfter ''
    dofile(os.getenv("HOME") .. "/.hewnix-ext/lua/neo-tree.lua")
  '';
}
