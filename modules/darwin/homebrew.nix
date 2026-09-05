{ inputs, userConfig, ... }:

{
  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  nix-homebrew = {
    # Install Homebrew under the default prefix
    enable = true;
    # Apple Silicon Only: also install Homebrew under the default
    # Intel prefix for Rosetta 2
    enableRosetta = true;
    # User owning the Homebrew prefix
    user = userConfig.user;
    # if Homebrew already installed in your system
    autoMigrate = true;
  };

  # Homebrew packages
  homebrew = {
    enable = true;
    brews = [ "mas" ];
    casks = [
      "the-unarchiver"
    ];
    # install pkgs from App Store, to get pkg id run: mas search <pkg-name>
    # masApps = {
    #   "<pkg-name>" = 123(id)
    # };
    # onActivation.cleanup = "zap";
    # onActivation.autoUpdate = true;
    # onActivation.upgrade = true;
  };
}
