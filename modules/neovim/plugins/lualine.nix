# plugins/lualine.nix
#-------------------------------------------------------------------------------
# Lualine status line configuration
# Actual config in lua/lualine-config.lua for linting
#-------------------------------------------------------------------------------
{ lib, ... }:

{
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = lib.mkForce { };
  };

  programs.nixvim.extraConfigLuaPost = ''
    dofile(os.getenv("HOME") .. "/.hewnix-ext/lua/lualine.lua")
  '';
}
