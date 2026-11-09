{ inputs, pkgs, userConfig, packagesFile, ... }:

let
  packages = import packagesFile { inherit pkgs; };
  brew = packages.homebrew;
in
{
  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = userConfig.user;
    autoMigrate = true;
  };

  # Taps, brews, casks and the cleanup mode come from packages.nix.
  homebrew = {
    enable = true;
    taps = brew.taps or [ ];
    brews = brew.brews or [ ];
    casks = brew.casks or [ ];
    onActivation.cleanup = brew.cleanup or "none";
  };
}
