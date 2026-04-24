# plugins/todo-comments.nix
#-------------------------------------------------------------------------------
# Highlight TODO, FIXME, NOTE, etc in comments
# Config in lua/todo-comments-config.lua
#-------------------------------------------------------------------------------
{ ... }:

{
  programs.nixvim.plugins.todo-comments = {
    enable = true;
    settings = { signs = false; };
  };
}
