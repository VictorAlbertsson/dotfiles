{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "victor";
  home.homeDirectory = "/home/victor";

  # User X session
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = haskellPackages: [
      haskellPackages.xmobar
    ];
  };

  # Configure-less user programs
  home.packages = [
    # System utilities
    pkgs.git
    pkgs.wget
    pkgs.htop
    pkgs.neofetch
    pkgs.calc # TO BE REPLACED by rofi-calc
    pkgs.xmobar
    #pkgs.rofi-calc # Not working
    # Programming languages
    pkgs.zig
    # Games
    pkgs.steam # Unfree
    pkgs.multimc
    # Other
    pkgs.deluge
    pkgs.cmus
  ];

  # User programs
  programs = {
    home-manager.enable = true; # Allow home-manager to update itself
    rofi = { # Graphical pop-up menu (program launcher)
      enable = true;
      pass = { # Password menu
        enable = true;
      };
    };
    vim = { # Text editor
      enable = true;
      plugins = with pkgs.vimPlugins; [
        # Cosmetics
        vim-airline
        # Languages
        vim-nix
        zig-vim
      ];
      settings = {
        ignorecase = true;
        expandtab = true;
        mouse = "a";
      };
      extraConfig = ''
        set lazyredraw
        let g:markdown_folding = 1
        '';
    };
    newsboat = { # RSS reader
      enable = true;
      urls = [
        { 
          url = "http://lambda-the-ultimate.org/rss.xml"; 
          tags = [ "programming" "language design" ];
          title = "Lambda the Ultimate";
        }
      ];
    };
    taskwarrior = { # Task manager
      enable = true;
      dataLocation = "${config.xdg.dataHome}/.task";
    };
    zathura.enable = true; # PDF viewer
    kitty.enable = true; # Terminal
    brave.enable = true; # Browser
  };

  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "default-web-browser" = "brave-browser.desktop";
      "text/html" = "brave-browser.desktop";
    };
  };

  # User services
  services.syncthing.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}
