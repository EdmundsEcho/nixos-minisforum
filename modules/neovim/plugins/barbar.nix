# plugins/barbar.nix
#-------------------------------------------------------------------------------
# Barbar - tabs at the top of the window
# Config in lua/barbar-config.lua
#-------------------------------------------------------------------------------
{ lib, ... }:

{
  programs.nixvim.plugins.bufferline.enable = lib.mkForce false;

  programs.nixvim.plugins.barbar = {
    enable = true;
    settings = lib.mkForce { };
  };

  programs.nixvim.extraConfigLua = lib.mkAfter ''
    dofile(os.getenv("HOME") .. "/.hewnix-ext/lua/barbar.lua")
  '';
}
