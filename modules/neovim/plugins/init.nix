# plugins/init.nix
#-------------------------------------------------------------------------------
# Imports all plugin configurations
#-------------------------------------------------------------------------------
{ ... }:

{
  imports = [
    ./barbar.nix
    ./conform.nix
    ./indentline.nix
    ./lualine.nix
    ./neo-tree.nix
    ./project.nix
    ./python.nix
    ./rustacean.nix
    ./telescope.nix
    ./todo-comments.nix
    ./tmux-navigation.nix
    ./treesitter.nix
    # lsps
    ./lsp-keybindings.nix
    ./lua-lsp.nix
  ];
}
