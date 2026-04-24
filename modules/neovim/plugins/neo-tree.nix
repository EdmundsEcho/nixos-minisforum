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

  # Enable neo-tree but clear nixvim's settings
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    settings = lib.mkForce { };
  };

  # Load our config
  programs.nixvim.extraConfigLua = lib.mkAfter ''
    dofile(os.getenv("HOME") .. "/.hewnix-ext/lua/neo-tree.lua")
  '';
}
