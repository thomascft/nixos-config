{pkgs, ...}:{
  environment.systemPackages = with pkgs; [
    helix
    github-cli
    nushell
  ];

  programs.git.enable = true;
  programs.starship.enable = true;

  users.defaultUserShell = pkgs.nushell;
}
