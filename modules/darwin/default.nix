{ ... }:

{
  imports = [
    ../shared

    ./security.nix
    ./system-defaults.nix
    ./homebrew.nix
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
