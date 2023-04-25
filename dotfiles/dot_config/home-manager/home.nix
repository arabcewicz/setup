{
  config,
  pkgs,
  ...
}: {
  programs.home-manager.enable = true;

  home = {
    username = "adrab";
    homeDirectory = "/home/adrab";
    stateVersion = "22.11";

    packages = with pkgs; [
      bat
      nnn
    ];

  };


  targets.genericLinux.enable = true;
  fonts.fontconfig.enable = true;

  #xdg.enable = true;
  #xdg.mime.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = ''
      colorscheme gruvbox
    '';
    plugins = with pkgs.vimPlugins; [
      gruvbox
      vim-nix
      {
        plugin = kommentary;
        type   = "lua";
        config = ''
          vim.api.nvim_set_keymap("n", "<C-_>", "<Plug>kommentary_line_default", {})
          vim.api.nvim_set_keymap("v", "<C-_>", "<Plug>kommentary_visual_default", {}) 
        '';
      }
      {
        plugin = vim-visual-multi;
        config = ''
          let g:VM_maps = {}
          let g:VM_maps['Find Under']         = '<M-n>'
          let g:VM_maps['Find Subword Under'] = '<M-n>'
          let g:VM_maps['Select All']         = '<M-C-n>'
          let g:VM_maps['Start Regex Search'] = '<M-/>'
          let g:VM_maps["Select Cursor Down"] = '<M-C-j>'
          let g:VM_maps["Select Cursor Up"]   = '<M-C-k>'
          let g:VM_maps["Skip Region"]        = '<M-x>'
        '';
      }
    ];
  };


  programs.zsh = {
    enable = true;
    autocd = true;
    #dotDir = "${config.xdg.configHome}/zsh";
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -al";
      hm = "home-manager";
      hmd = "cd ~/.config/home-manager";
      hms = "home-manager switch --flake ~/.config/home-manager#adrab";
      hme = "home-manager edit";
      hmp = "home-manager packages";
      hmu = "nix flake update ~/.config/home-manager && hms";
    };
    sessionVariables = rec {
      EDITOR = "vim";
      MANPAGER="nvim +Man!";
    };
    history = {
      expireDuplicatesFirst = true;
      save = 100000000;
      size = 1000000000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    initExtra = ''
      autopair-init
    '';

    plugins = with pkgs; [

      {
        name = "zsh-autopair";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
          sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
        };
      #  file = "autopair.zsh";
      }
    {
      name = "zsh-vi-mode";
      src = builtins.fetchGit {
        url = "https://github.com/jeffreytse/zsh-vi-mode";
        rev = "0b1381bd2b23b966881e2bca426216a47f7f3403";
      };
    }

    ];

  };

  programs.starship.enable = true;
  programs.starship.settings = {
    add_newline = false;
    format = "$shlvl$username$hostname$nix_shell$git_branch$git_commit$git_state$git_status$directory$jobs$cmd_duration$character";
    shlvl = {
      disabled = false;
      symbol = "ﰬ";
      style = "bright-red bold";
    };
    username = {
      style_user = "bright-white bold";
      style_root = "bright-red bold";
    };
    hostname = {
      style = "bright-green bold";
      ssh_only = true;
    };
    nix_shell = {
      symbol = "";
      format = "[$symbol$name]($style) ";
      style = "bright-purple bold";
    };
    git_branch = {
      only_attached = true;
      format = "[$symbol$branch]($style) ";
      symbol = "שׂ";
      style = "bright-yellow bold";
    };
    git_commit = {
      only_detached = true;
      format = "[ﰖ$hash]($style) ";
      style = "bright-yellow bold";
    };
    git_state = {
      style = "bright-purple bold";
    };
    git_status = {
      style = "bright-green bold";
    };
    directory = {
      read_only = " ";
      truncation_length = 0;
    };
    cmd_duration = {
      format = "[$duration]($style) ";
      style = "bright-blue";
    };
    jobs = {
      style = "bright-green bold";
    };
    character = {
      success_symbol = "[\\$](bright-green bold)";
      error_symbol = "[\\$](bright-red bold)";
    };
  };

}
