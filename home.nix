{ config, pkgs, lib, ... }:

let

  adr_tools = pkgs.stdenv.mkDerivation {
    name = "adr-tools";

    version = "3.0.0";

    src = pkgs.fetchFromGitHub {
      owner = "npryce";
      repo = "adr-tools";
      rev = "3.0.0";
      sha256 = "1igssl6853wagi5050157bbmr9j12703fqfm8cd7gscqwjghnk14";
    };

    buildPhase = ''
    echo nothing to build
  '';

    installPhase = ''
    mkdir -p $out/bin
    cp -R ./src/. $out/bin/
  '';


    meta = {
      homepage = https://github.com/npryce/adr-tools;
      description = "Command-line tools for working with Architecture Decision Records ";
      license = lib.licenses.cc-by-40;
      # maintainers = [ lib.maintainers.matklad ];
    };

  };

  elixir_lsp = pkgs.beam.packages.erlang.callPackage ./packages/elixir-lsp {};

  build_movelines = epkgs: epkgs.trivialBuild {
    pname = "move-lines";
    version = "2.0";

    src = pkgs.fetchFromGitHub {
      owner = "targzeta";
      repo = "move-lines";
      rev = "master";
      sha256 = "0pbvn11n9sw3mg3hpcpc8p80zh53sxyjbhqqxdwbwg8dwpc7r5ij";
    };

  };

  slime_company = epkgs: epkgs.trivialBuild {
    pname = "slime-company";
    version = "1.6";

    src = pkgs.fetchFromGitHub {
      owner = "anwyn";
      repo = "slime-company";
      rev = "master";
      sha256 = "0pbvn11n9sw3mg3hpcpc8p80zh53sxyjbhqqxdwbwg8dwpc7r5ij";
    };

  };

in
with lib;
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "user";
  home.homeDirectory = "/home/user";

  home.packages = with pkgs; [
    # Nix
    niv

    # Emacs
    inconsolata
    ctags

    # Common Lisp
    sbcl
    lispPackages.quicklisp

    # elixir
    # elixir_lsp

    # Clojure
    leiningen

    # Ergodox EZ
    qmk
    teensy-loader-cli

    # ADR CLI tools
    adr_tools
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
      cider
      dash
      dumb-jump
      duplicate-thing
      # erlang
      eglot
      elixir-mode
      exunit  # elixir unit tests
      expand-region
      flycheck-credo
      helm
      helm-ag
      magit
      markdown-mode
      merlin
      monokai-theme
      (build_movelines epkgs)
      multiple-cursors
      nix-mode
      org
      paredit
      projectile
      protobuf-mode
      rust-mode
      slime
      slime-company
      smartparens
      tuareg
      undo-tree
      use-package
      visual-regexp
      wgrep
      wgrep-ag
      whitespace-cleanup-mode
      yaml-mode
      yasnippet
      # epkgs."ido-completing-read+"
      outshine
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

    profileExtra = "export PATH=$PATH:$HOME/.cache/rebar3/bin:$HOME/local/bin:$HOME/.local/bin:$HOME/projects/extern/elixir-ls/myrelease";

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

  home.file."elixir.ctags" = {
    source = ./home_files/dot.ctags;
    target = ".ctags";
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
