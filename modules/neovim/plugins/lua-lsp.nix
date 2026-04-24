# plugins/lua-lsp.nix
#-------------------------------------------------------------------------------
# Lua language server configuration - fix settings nesting
#-------------------------------------------------------------------------------
{ lib, pkgs, ... }:

{
  # Override the lua_ls settings (base config has incorrect nesting)
  programs.nixvim.plugins.lsp.servers.lua_ls.settings = lib.mkForce {
    runtime = { version = "LuaJIT"; };
    diagnostics = { globals = [ "vim" "_G" ]; };
    workspace = {
      library.__raw = "{ vim.env.VIMRUNTIME }";
      checkThirdParty = false;
    };
    telemetry = { enable = false; };
    hint = {
      enable = true;
      setType = true;
      paramType = true;
    };
  };
}
