{ pkgs, self, userConfig, ... }:

{
  imports = [
    ../modules/darwin
  ];

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # The platform & user this configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.primaryUser = userConfig.user;
}
