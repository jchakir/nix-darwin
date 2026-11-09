{ ... }:

{
  # One file per concern; the order that matters is checked in order-check.nix.
  # `programs.zsh.enable` comes from the `zsh` entry in packages.nix (homeTools).
  imports = [
    ./environment.nix
    ./history.nix
    ./plugins.nix
    ./completion.nix
    ./keybindings.nix
    ./aliases.nix
    ./tools.nix
    ./order-check.nix
  ];

  programs.zsh = {
    autocd = true;

    setOptions = [
      "INTERACTIVE_COMMENTS"
      "EXTENDED_GLOB"
      "NO_BEEP"
      "AUTO_PUSHD"
      "PUSHD_IGNORE_DUPS"
      "PUSHD_MINUS"
    ];
  };
}
