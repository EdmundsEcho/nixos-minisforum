# plugins/indent-blankline.nix
#-------------------------------------------------------------------------------
# Indent guides
# Config in lua/indent-blankline-config.lua
#-------------------------------------------------------------------------------
{ lib, ... }:

{
  # Disable nixvim's indent-blankline config (we configure manually)
  programs.nixvim.plugins.indent-blankline = {
    enable = true;
    settings = lib.mkForce { };
  };

  # Load our config
  programs.nixvim.extraConfigLua = lib.mkAfter ''
    dofile(os.getenv("HOME") .. "/.hewnix-ext/lua/indentline.lua")
  '';
}
