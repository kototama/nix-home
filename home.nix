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

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.magit
    ];
  };

  programs.ssh.enable = true;

  programs.dircolors.enable = true;

  fonts.fontconfig.enable = true;

  home.file."detectencoding" = {
    source = ~/.config/nixpkgs/home_files/detectencoding.py;
    target = "local/bin/detectencoding.py";
  };

  home.file."flush-fw" = {
    source = ~/.config/nixpkgs/home_files/flush-fw.sh;
    target = "local/bin/flush-fw.sh";
  };

  # hosts specific configuration
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
