{ userConfig, pkgs, ... }:

{
  imports = [
    ./programs.nix
    ./ssh
    ./zsh
    ./zellij
    ./oh-my-posh
    ./nvim
    # ./omniwm
  ];

  home.username = userConfig.user;
  home.homeDirectory = userConfig.home;
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    font-awesome
    superfile
    opencode-desktop
    codex
  ];
}
