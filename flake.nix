{
  description = "My home and system configuration.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  inputs.disko.url = "github:nix-community/disko";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";

  inputs.lanzaboote.url = "github:nix-community/lanzaboote";
  inputs.lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

  inputs.zen-browser.url = "github:0xc000022070/zen-browser-flake/beta";
  inputs.zen-browser.inputs.nixpkgs.follows = "nixpkgs";

  inputs.nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = inputs @ {self, nixpkgs, home-manager, ...}:{
    nixosConfigurations.gram = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs self; };
      modules = [ ./system/hosts/gram ];
    };
    nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs self; };
      modules = [ ./system/hosts/wsl ];
    };
    homeConfigurations."thomas@gram" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      modules = [ ./home/profiles/gram ];
    };
  };
}
