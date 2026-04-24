# nvim-keybindings.nix
#-------------------------------------------------------------------------------
# Keybindings - loads lua/keybindings.lua
#-------------------------------------------------------------------------------
{ lib, ... }:

{
  # Clear nixvim's default keymaps to avoid conflicts
  programs.nixvim.keymaps = lib.mkForce [ ];

  programs.nixvim.extraConfigLua = lib.mkAfter ''
    dofile(os.getenv("HOME") .. "/.hewnix-ext/lua/keybindings.lua")
  '';
}
