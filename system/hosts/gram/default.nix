{pkgs, ...}:{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ./secure-boot.nix
    ./desktop-environment.nix
  ];

  time.timeZone = "America/Denver";

  users.users.thomas = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = [ "int3404_thermal" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  networking.hostName = "gram";
  networking.wireless.iwd.enable = true;
  hardware.bluetooth.enable = true;

  services.thermald.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  services.syncthing.enable = true;

  environment.systemPackages = with pkgs; [
    helix
    git
    github-cli
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}

