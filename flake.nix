{
  description = "My home and system configuration.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  inputs.disko.url = "github:nix-community/disko";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";

  inputs.lanzaboote.url = "github:nix-community/lanzaboote";
  inputs.lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

  inputs.zen-browser.url = "github:0xc000022070/zen-browser-flake/beta";
  inputs.zen-browser.inputs.nixpkgs.follows = "nixpkgs";

  outputs = inputs @ {self, nixpkgs, ...}:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
  {
    nixosConfigurations.gram = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs self; };
      modules = [
        ({pkgs, config, ...}:{
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

          programs.niri.enable = true;
          
          services.pipewire.enable = true;
          services.pipewire.audio.enable = true;

          environment.systemPackages = with pkgs; [
            helix
            ghostty
            wofi
            git
            github-cli
            obsidian
            microsoft-edge
          ] ++ [
            inputs.zen-browser.packages.${stdenv.hostPlatform.system}.default
          ];
          
          services.greetd = {
            enable = true;
            settings = {
              default_session = {
                command = "${config.services.greetd.package}/bin/agreety --cmd ${config.programs.niri.package}/bin/niri-session";
              };
            };
          };

          nix.settings.experimental-features = [ "nix-command" "flakes" ];
          nixpkgs.config.allowUnfree = true;

          system.stateVersion = "25.11";
        })
        # Secure Boot and TPM Unlocking
        ({inputs, lib, pkgs, config, ...}:{
          imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
          boot.loader.systemd-boot.enable = lib.mkForce false;
          boot.lanzaboote = {
            enable = true;
            pkiBundle = "/var/lib/sbctl";
          };


          boot.initrd.systemd.enable = true;
        })
        ({...}:{
          programs.dconf.profiles.user.databases = [{
            lockAll = true;
            settings = {
              "org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
              };
            };
          }];
        })
        ./systems/gram/disko.nix
        ./systems/gram/hardware-configuration.nix
      ];
    };
  };
}
