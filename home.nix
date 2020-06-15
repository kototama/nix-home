{ config, pkgs, lib, ... }:

with lib;
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "user";
  home.homeDirectory = "/home/user";

  home.packages = with pkgs; [
    inconsolata
  ];

  home.sessionVariables = {
    EDITOR="emacsclient";
    ALTERNATE_EDITOR = ""; # this will start emacs server if not running when invoking emacsclient
  };

  programs.emacs = {
    enable = true;
    # packages can be searched with "nix-env -f '<nixpkgs>' -qaP -A emacsPackages"
    extraPackages = epkgs: with epkgs; [
      ace-jump-mode
      ag
      auto-indent-mode
      browse-kill-ring
      clojure-mode
      company
      dash
      dumb-jump
      duplicate-thing
      elixir-mode
      expand-region
      flycheck-credo
      magit
      markdown-mode
      monokai-theme
      multiple-cursors
      nix-mode
      org
      paredit
      projectile
      protobuf-mode
      rust-mode
      smartparens
      smex
      undo-tree
      use-package
      visual-regexp
      wgrep
      whitespace-cleanup-mode
      yaml-mode
      epkgs."ido-completing-read+"
    ];
  };

  fonts.fontconfig.enable = true;

  programs.ssh.enable = true;

  programs.dircolors = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.broot.enable = false;

  programs.bash = {
    enable = true;

    initExtra = ''
    source ~/local/bin/prompt.sh
    source ~/.nix-profile/etc/profile.d/nix.sh
    '';

    profileExtra = ''
    export PATH=$PATH:~/local/bin:~/.local/bin;
    '';

    shellAliases = {
      ls = "ls --color";
      ll = "ls -Al --color";
      la = "ls -A --color";
      e = "emacs";
      ec = "emacsclient";
    };
  };

  home.file."detectencoding" = {
    source = ./home_files/detectencoding.py;
    target = "local/bin/detectencoding.py";
  };

  home.file."flush-fw" = {
    source = ./home_files/flush-fw.sh;
    target = "local/bin/flush-fw.sh";
  };

  home.file."prompt.sh" = {
    source = ./home_files/prompt.sh;
    target = "local/bin/prompt.sh";
  };

  # hosts specific configurations
  imports = [ ./hosts ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}
