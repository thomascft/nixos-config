{inputs, pkgs, config, ...}:{
  programs.niri.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${config.services.greetd.package}/bin/agreety --cmd ${config.programs.niri.package}/bin/niri-session";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    ghostty
    wofi
    obsidian
    microsoft-edge
    spotify
    swww
    mako
  ] ++ [
    inputs.zen-browser.packages.${stdenv.hostPlatform.system}.default
  ];

  services.pipewire.enable = true;
  services.pipewire.audio.enable = true;

  # Dark Mode
  programs.dconf.profiles.user.databases = [{
    lockAll = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  }];
}
