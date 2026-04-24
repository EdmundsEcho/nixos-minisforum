{ lib, ... }:

{
  # Disable the base nixvim config and replace with ours
  programs.nixvim = {
    enable = lib.mkForce true;

    # Disable wilder - it breaks command line <CR>
    plugins = { wilder.enable = lib.mkForce false; };

    # Set the colorscheme to default
    colorscheme = lib.mkForce "";

    #---------------------------------------------------------------------------
    # Global settings
    #---------------------------------------------------------------------------
    globals = {
      mapleader = " ";
      maplocalleader = " ";
      have_nerd_font = true;

      # Disable providers we don't need
      loaded_perl_provider = 0;
      loaded_node_provider = 0;
      loaded_ruby_provider = 0;
      loaded_python_provider = 0;
      loaded_python3_provider = 0;

      # netrw style
      netrw_liststyle = 3;
    };

    #---------------------------------------------------------------------------
    # Options (from nvim-settings.lua)
    #---------------------------------------------------------------------------
    opts = lib.mkForce {
      # Clipboard - empty string lets vim.g.clipboard (OSC 52) take over
      clipboard = "";

      # Line numbers
      number = true;
      relativenumber = true;

      # Tabs and indentation
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      autoindent = true;
      smartindent = true;
      smarttab = true;

      # Search
      ignorecase = true;
      smartcase = true;
      hlsearch = true;
      incsearch = true;
      gdefault = true;
      magic = true;

      # UI
      termguicolors = true;
      background = "dark";
      showmode = true;
      signcolumn = "yes";
      cursorline = true;
      cmdheight = 1;
      updatetime = 300;

      # Scrolling
      scrolloff = 10;
      sidescrolloff = 5;
      sidescroll = 1;

      # Text display
      textwidth = 88;
      colorcolumn = "+1";
      wrap = false;
      linebreak = true;
      breakindent = true;

      # Splits
      splitbelow = true;
      splitright = true;

      # Files and backup
      autoread = true;
      autowrite = true;
      backup = false;
      writebackup = false;
      swapfile = false;
      hidden = true;

      # Undo
      undofile = true;
      undolevels = 1000;

      # Folding
      foldmethod = "indent";
      foldlevel = 8;
      foldnestmax = 20;
      foldenable = true;

      # Completion and command line
      inccommand = "split";
      showmatch = true;
      matchtime = 2;

      # Mouse
      mouse = "a";

      # Encoding
      encoding = "utf-8";
      fileformats = "unix,dos,mac";

      # Misc
      errorbells = false;
      visualbell = true;
      list = true;
      listchars = "tab:» ,trail:·,nbsp:␣";
      timeout = true;
      timeoutlen = 500;
      history = 2000;

      # Spelling
      spell = false;
      spelllang = "en";

      # Persist jumplist in shada file
      # ' = number of files to remember marks for
      # f = store file marks
      # < = max lines saved per register
      shada = "'1000,f1,<500,:100,/100,h";
    };

    #---------------------------------------------------------------------------
    # Autocommands
    #---------------------------------------------------------------------------
    autoGroups = {
      AutoCheckTime = { clear = true; };
      TrimWhitespace = { clear = true; };
      QuickExit = { clear = true; };
      QuickfixSettings = { clear = true; };
    };

    autoCmd = [
      # Auto check for external file changes
      {
        event = [ "FocusGained" "BufEnter" "CursorHold" "CursorHoldI" ];
        group = "AutoCheckTime";
        callback.__raw = ''
          function()
            if vim.api.nvim_get_mode().mode ~= "c" then
              vim.cmd.checktime()
            end
          end
        '';
      }

      # Trim whitespace on save (except markdown)
      {
        event = "BufWritePre";
        group = "TrimWhitespace";
        pattern = "*";
        callback.__raw = ''
          function()
            local ft = vim.bo.filetype
            if ft == "markdown" or ft == "pandoc" then return end
            if vim.bo.modifiable and not vim.bo.readonly then
              local save_cursor = vim.fn.getpos(".")
              pcall(function() vim.cmd("%s/\\s\\+$//e") end)
              vim.fn.setpos(".", save_cursor)
            end
          end
        '';
      }

      # Quick q to exit help
      {
        event = "FileType";
        group = "QuickExit";
        pattern = [ "help" "qf" "man" "notify" "lspinfo" ];
        callback.__raw = ''
          function(event)
            vim.bo[event.buf].buflisted = false
            vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
          end
        '';
      }

      # Quickfix settings
      {
        event = "FileType";
        group = "QuickfixSettings";
        pattern = "qf";
        callback.__raw = ''
          function()
            vim.opt_local.wrap = true
            vim.opt_local.number = false
            vim.opt_local.colorcolumn = ""
          end
        '';
      }

      # Diagnostic float on hover
      {
        event = "CursorHold";
        pattern = "*";
        callback.__raw = ''
          function()
            vim.diagnostic.open_float(nil, { focusable = false })
          end
        '';
      }
    ];

    #---------------------------------------------------------------------------
    # Extra Lua config (OSC 52 clipboard + custom functions)
    #---------------------------------------------------------------------------

    extraConfigLua = lib.mkAfter ''
      dofile(os.getenv("HOME") .. "/.hewnix-ext/lua/options.lua")
    '';
  };

  warnings = [ ">>>> .hewnix-ext/neovim.nix is being loaded" ];
}
