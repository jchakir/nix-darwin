{ lib, pkgs, packagesFile, ... }:

{
  imports = [
    ./programs.nix
    ./ssh
    ./zsh
    ./zellij
    ./oh-my-posh
    ./nvim
  ];

  home.stateVersion = "26.05";

  # programs.<name>.enable for every `homeTools` entry in packages.nix.
  programs = lib.genAttrs
    (import packagesFile { inherit pkgs; }).homeTools
    (_: { enable = true; });
}
