{ pkgs, ... }:{
    
  imports = [
    
  ];

  flake.homeModules.desktop-environment = {inputs, pkgs, config, ...}:{
    home.packages = with pkgs; [
      ghostty
      obsidian
      microsoft-edge
      spotify

      wofi
      swww
      mako
      ashell
      hyprlock
      hypridle
      hyprpaper
      hypridle

      brightnessctl
      playerctl
      glib

      jetbrains-mono
    ] ++ [
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    fonts.fontconfig.enable = true;

    xdg.configFile."niri" = {
      source = config.lib.file.mkOutOfStoreSymlink ./niri-config;
      recursive = true;
    };
  };

  flake.nixosModules.desktop-environment = {
    services.displayManager.gdm.enable = true;
    programs.niri.enable = true;
    services.pipewire.enable = true;
    services.pipewire.audio.enable = true;

    # Dark Mode
    programs.dconf.profiles.user.databases = [{
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    }];
  };
}
