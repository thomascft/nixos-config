{ pkgs, ...}:{

  time.timeZone = "America/Denver";
  
  users.users.thomas = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    helix
    git
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
}
