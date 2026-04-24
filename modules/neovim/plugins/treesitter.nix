# plugins/treesitter.nix
#-------------------------------------------------------------------------------
# Treesitter configuration
# Translated from: plugins/treesitter.lua
#-------------------------------------------------------------------------------
{ lib, ... }:

{
  programs.nixvim.plugins.treesitter = {
    enable = true;

    settings = {
      sync_install = true;

      ensure_installed = [
        "bash"
        "c"
        "cpp"
        "css"
        "dockerfile"
        "fish"
        "gitignore"
        "haskell"
        "html"
        "javascript"
        "json"
        "lua"
        "markdown"
        "nu"
        "python"
        "rust"
        "svelte"
        "toml"
        "typescript"
        "vim"
        "vimdoc"
        "yaml"
      ];

      highlight = {
        enable = true;
        disable = [ ];
      };

      indent = {
        enable = true;
        disable = [ "yaml" "ruby" ];
      };

      incremental_selection = {
        enable = true;
        keymaps = {
          init_selection = lib.mkForce "snn";
          node_incremental = lib.mkForce "snn";
          node_decremental = lib.mkForce "snm";
          scope_incremental = lib.mkForce "snc";
        };
      };
    };

    folding = true;
  };

  # nvim-ts-autotag
  programs.nixvim.plugins.ts-autotag = {
    enable = true;
    settings = {
      opts = {
        enable_close = true;
        enable_rename = true;
        enable_close_on_slash = false;
      };
    };
  };

  # Override fold settings for treesitter
  programs.nixvim.extraConfigLua = lib.mkAfter ''
    -- Treesitter folding (overrides indent-based folding)
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldenable = true
  '';
}
