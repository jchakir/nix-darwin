{ userConfig, pkgs, ... }:

{
  imports = [ ./zsh.nix ];

  home.username = userConfig.user;
  home.homeDirectory = userConfig.home;
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    superfile
    opencode-desktop
    codex
  ];

  programs.git.enable = true;
  programs.git.settings.user = {
    name = userConfig.git.name;
    email = userConfig.git.email;
  };
}
