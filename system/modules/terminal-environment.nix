{pkgs, ...}:{
  environment.systemPackages = with pkgs; [
    helix
    git
    github-cli

    nushell
  ];
}
