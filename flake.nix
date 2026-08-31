{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    # home-manager.url = "github:nix-community/home-manager";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, nix-homebrew }:
    let
      userConfig = import ./user-config.nix;
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#jmac
      darwinConfigurations.${userConfig.hostname} = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs self userConfig; };
        modules = [
          ./hosts/jmac.nix
        ];
      };
    };
}
