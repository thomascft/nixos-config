{ inputs, ... }:{
  imports = [
    inputs.nixos-wsl.nixosModules.default

    ../../modules/base.nix
    ../../modules/terminal-environment.nix
  ];

  networking.hostName = "rootkitbox-wsl";

  wsl.enable = true;
  wsl.defaultUser = "thomas";

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.11";
}
