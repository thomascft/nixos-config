{inputs, lib, ...}:{
  flake.nixosModules.secure-boot = {
    imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };

    boot.initrd.systemd.enable = true;
  };
}
