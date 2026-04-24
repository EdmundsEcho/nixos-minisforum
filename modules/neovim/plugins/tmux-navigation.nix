# plugins/nvim-tmux-navigation.nix
#-------------------------------------------------------------------------------
# Tmux/Neovim navigation integration
# Conditionally activates based on $TMUX environment variable
#-------------------------------------------------------------------------------
{ lib, pkgs, ... }:

{
  programs.nixvim.extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "nvim-tmux-navigation";
      src = pkgs.fetchFromGitHub {
        owner = "alexghergh";
        repo = "nvim-tmux-navigation";
        rev = "master";
        # nix will tell you the correct hash
        hash = "sha256-CxAgQSbOrg/SsQXupwCv8cyZXIB7tkWO+Y6FDtoR8xk=";
      };
    })
  ];

  programs.nixvim.extraConfigLua = lib.mkAfter ''
    dofile(os.getenv("HOME") .. "/.hewnix-ext/lua/tmux-navigation.lua")
  '';
}
