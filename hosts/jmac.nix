{ pkgs, self, userConfig, ... }:

{
  imports = [
    ../modules/darwin
  ];

  system.configurationRevision = self.rev or self.dirtyRev or null;

  nixpkgs.hostPlatform = "aarch64-darwin";
  system.primaryUser = userConfig.user;
}
