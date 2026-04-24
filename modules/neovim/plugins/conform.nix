# plugins/conform.nix
#-------------------------------------------------------------------------------
# Conform.nvim - formatting manager
# Config in lua/conform-config.lua
#-------------------------------------------------------------------------------
{ lib, pkgs, ... }:

{
  # Install formatters via Nix
  programs.nixvim.extraPackages = with pkgs; [
    # Lua
    stylua

    # Python
    ruff

    # Web
    prettierd
    nodePackages.prettier

    # JSON
    jq

    # TOML
    taplo

    # Fish
    fish
  ];

  # Enable conform but configure via lua
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings = lib.mkForce { };
  };

  # Load our config
  programs.nixvim.extraConfigLua = lib.mkAfter ''
    dofile(os.getenv("HOME") .. "/.hewnix-ext/lua/conform.lua")
  '';
}
