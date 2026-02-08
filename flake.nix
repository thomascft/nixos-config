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
    # let
    #   pkgs = nixpkgs.legacyPackages.x86_64-linux;
    # in
  {
    nixosConfigurations.gram = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs self; };
      modules = [ ./system/hosts/gram ];
    };
  };
}
