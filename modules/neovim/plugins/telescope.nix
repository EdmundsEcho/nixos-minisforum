# plugins/telescope.nix
#-------------------------------------------------------------------------------
# Telescope fuzzy finder configuration
# Translated from: plugins/telescope.lua
#-------------------------------------------------------------------------------
{ ... }:

{
  programs.nixvim.plugins.telescope = {
    enable = true;

    extensions = {
      fzf-native.enable = true;
      ui-select.enable = true;
    };

    settings = {
      defaults = {
        path_display = [ "smart" ];
        mappings = {
          i = {
            "<C-k>" = {
              __raw = "require('telescope.actions').move_selection_previous";
            };
            "<C-j>" = {
              __raw = "require('telescope.actions').move_selection_next";
            };
          };
        };
      };
    };

    keymaps = {
      "<leader>ff" = {
        action = "find_files";
        options = { desc = "[F]ile [F]uzzy find files in cwd"; };
      };
      "<leader>fr" = {
        action = "oldfiles";
        options = { desc = "[F]ile Fuzzy find [R]ecent files"; };
      };
      "<leader>fs" = {
        action = "live_grep";
        options = { desc = "[F]ind [S]tring in cwd"; };
      };
      "<leader>fc" = {
        action = "grep_string";
        options = { desc = "[F]ind string under [C]ursor in cwd"; };
      };
    };
  };

  # project.nvim for project root detection
  programs.nixvim.plugins.project-nvim = {
    enable = true;
    enableTelescope = true;

    settings = {
      manual_mode = true;
      detection_methods = [ "lsp" "pattern" ];
      exclude_dirs = [ "~/.cargo/*" ];
      patterns = [
        ".git"
        "_darcs"
        ".hg"
        ".bzr"
        ".svn"
        "Makefile"
        "package.json"
        "pyproject.toml"
        "stack.yaml"
        "cabal.project"
        "Cargo.toml"
      ];
    };
  };

  # Web devicons for file icons
  programs.nixvim.plugins.web-devicons.enable = true;
}
