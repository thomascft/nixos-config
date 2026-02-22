{ inputs, self, config, pkgs, ... }:{
  flake.nixosConfigurations.gram = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs self; };
    modules = [
      config.flake.nixosModules.desktop-environment
      config.flake.nixosModules.terminal-environment
      config.flake.nixosModules.secure-boot
      ./hardware-configuration.nix
      ./disko.nix
      {
        networking.hostName = "gram";
        time.timeZone = "America/Denver";
        nixpkgs.hostPlatform = "x86_64-linux";
        system.stateVersion = "25.11";
      }
      ({pkgs, ...}:{
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

        services.resolved.enable = true;
        networking.wireless.iwd.enable = true;
        networking.wireless.iwd.settings = {
          General = {
            EnableNetworkConfiguration = true;
          };
        };

        networking.dhcpcd.enable = false; # We've enabled IWD's builtin DHCP client
        hardware.bluetooth.enable = true;

        services.thermald.enable = true;
        services.power-profiles-daemon.enable = true;
        services.upower.enable = true;

        services.syncthing.enable = true;
        services.tailscale.enable = true;
      })
      ({ pkgs, ...}:{
        time.timeZone = "America/Denver";
        environment.systemPackages = with pkgs; [
          helix
          git
        ];

        nix.settings.experimental-features = [ "nix-command" "flakes" ];
        nixpkgs.config.allowUnfree = true;
      })
    ];
  };
  flake.homeConfigurations."thomas@gram" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
    extraSpecialArgs = { inherit inputs self; };
    modules = [
      config.flake.homeModules.desktop-environment
      config.flake.homeModules.terminal-environment
      {
        home.username = "thomas";
        home.homeDirectory = "/home/thomas";
        home.stateVersion = "26.05";

        programs.home-manager.enable = true;

        nixpkgs.config.allowUnfree = true;
      }
    ];
  };
}
