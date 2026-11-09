{ self, userConfig, system, ... }:

{
  imports = [
    ./nix.nix
    ./software.nix
    ./security.nix
    ./system-defaults.nix
    ./zsh.nix
    ./homebrew.nix
    ./home-manager.nix
  ];

  system.configurationRevision = self.rev or self.dirtyRev or null;

  nixpkgs.hostPlatform = system;
  system.primaryUser = userConfig.user;

  # Read `darwin-rebuild changelog` before changing.
  system.stateVersion = 6;
}
