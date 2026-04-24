# plugins/rustacean.nix
#-------------------------------------------------------------------------------
# Rustacean.nvim - Enhanced Rust development
# Config in lua/rustacean-config.lua
#-------------------------------------------------------------------------------
{ lib, pkgs, ... }:

{
  # Disable the default rust-analyzer LSP (rustacean manages it)
  programs.nixvim.plugins.lsp.servers.rust_analyzer.enable = lib.mkForce false;

  # Enable rustacean plugin (but configure via lua)
  programs.nixvim.plugins.rustaceanvim.enable = true;

  # Ensure rust tools are installed
  programs.nixvim.extraPackages = with pkgs; [ rust-analyzer clippy rustfmt ];

  # Load config BEFORE rustacean initializes (must set vim.g.rustaceanvim early)
  programs.nixvim.extraConfigLuaPre = lib.mkAfter ''
    dofile(os.getenv("HOME") .. "/.hewnix-ext/lua/rustacean.lua")
  '';
}
