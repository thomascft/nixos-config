{ inputs, pkgs, ... }:{
  imports = [
    ../../modules/niri
  ];

  home.username = "thomas";
  home.homeDirectory = "/home/thomas";

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
