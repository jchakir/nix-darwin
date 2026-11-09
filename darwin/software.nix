{ pkgs, packagesFile, ... }:

let
  packages = import packagesFile { inherit pkgs; };
in
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = packages.system;
  fonts.packages = packages.fonts;
}
