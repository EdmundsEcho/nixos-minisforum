# plugins/project.nix
#-------------------------------------------------------------------------------
# Project.nvim - project root detection
# Using latest from GitHub to fix LSP detection warning
#-------------------------------------------------------------------------------
{ lib, pkgs, ... }:

{
  # Disable the nixvim-managed version
  programs.nixvim.plugins.project-nvim.enable = lib.mkForce false;

  # Add latest from GitHub
  programs.nixvim.extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "project.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "ahmedkhalf";
        repo = "project.nvim";
        rev = "master";
        # nix will tell you the correct hash
        hash = "sha256-avV3wMiDbraxW4mqlEsKy0oeewaRj9Q33K8NzWoaptU=";
      };
    })
  ];

  # Configure manually
  programs.nixvim.extraConfigLua = lib.mkAfter ''
    require("project_nvim").setup({
      detection_methods = { "pattern", "lsp" },
      patterns = {
        ".git",
        "Makefile",
        "Cargo.toml",
        "package.json",
        "flake.nix",
        "pyproject.toml",
        "go.mod",
      },
      silent_chdir = true,
      scope_chdir = "global",
    })
  '';
}
