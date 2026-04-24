# plugins/python.nix
#-------------------------------------------------------------------------------
# Python development - LSP and linting
# Formatting handled by conform.nix
#-------------------------------------------------------------------------------
{ pkgs, ... }:

{
  # Install Python tools via Nix
  programs.nixvim.extraPackages = with pkgs; [ basedpyright ruff ];

  # Enable basedpyright LSP
  programs.nixvim.plugins.lsp.servers.basedpyright = {
    enable = true;
    settings = {
      basedpyright = {
        analysis = {
          typeCheckingMode = "standard";
          autoImportCompletions = true;
          diagnosticMode = "openFilesOnly";
          useLibraryCodeForTypes = true;
          reportMissingTypeStubs = "warning";
        };
      };
    };
  };
}
