{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, ... }:
    let
      system = "aarch64-darwin";
      userConfig = import ./user-config.nix;
      # Where this checkout lives: feeds the Neovim link, which the zshrc alias follows.
      repoPath = "${userConfig.home}/nix-darwin";
    in
    {
      darwinConfigurations.${userConfig.hostname} = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs self userConfig system repoPath;
          packagesFile = ./packages.nix;
        };
        modules = [
          ./darwin
        ];
      };
    };
}
