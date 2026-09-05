{ pkgs, ... }:

{
  # allow install of closed source packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # CLI tools for the user live in home/default.nix (home.packages).
  environment.systemPackages = with pkgs; [
    obsidian
    firefox
    brave
    curl
    wget
    zip
    unzip
    zsh
  ];
}
