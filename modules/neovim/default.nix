{ ... }:
#
# Nixvim config lifted from ~/.hewnix-ext. Self-contained module — the flake
# brings in the `nixvim` input and this module extends `programs.nixvim`.
#
{
  imports = [
    ./neovim.nix
    ./keybindings.nix
    ./colors.nix
    ./highlights.nix
    ./plugins/init.nix
  ];
}
