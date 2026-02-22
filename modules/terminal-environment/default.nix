{pkgs, ...}:{
  flake.nixosModules.terminal-environment = { pkgs, ...}:{
    environment.systemPackages = with pkgs; [
      git
      helix
      github-cli
      nushell
    ];

    programs.git.enable = true;
    programs.starship.enable = true;
    # users.defaultUserShell = pkgs.nushell;
  };

  flake.homeModules.terminal-environment = {
    programs.helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        theme = "tokyonight";
        editor = {
          cursorline = true;
          color-modes = true;
          indent-guides.render = true;
        };
      };
    };
  };
}
