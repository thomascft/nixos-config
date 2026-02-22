{ inputs, config, ... }:{
  flake.nixosConfigurations.wsl = inputs.nixpkgs.lib.nixosSystem {
    
    modules = [
      inputs.nixos-wsl.nixosModules.default
      config.nixosModules.terminal-environment
    ];

    networking.hostName = "rootkitbox-wsl";

    wsl.enable = true;
    wsl.defaultUser = "thomas";

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "25.11";
  };
}
