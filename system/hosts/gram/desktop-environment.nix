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

  ] ++ [
    inputs.zen-browser.packages.${stdenv.hostPlatform.system}.default
  ];

  fonts.packages = with pkgs; [
    maple-mono.truetype
    jetbrains-mono
  ];

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
}
