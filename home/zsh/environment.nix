{ config, lib, ... }:

{
  home.sessionVariables = {
    BUN_INSTALL = "${config.home.homeDirectory}/.bun";
    PNPM_HOME = "${config.home.homeDirectory}/.local/share/pnpm";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/go/bin"
  ];

  # Early block, ahead of everything else Home Manager writes into .zshrc.
  programs.zsh.initContent = lib.mkBefore ''
    # pnpm keeps binaries directly in $PNPM_HOME (no /bin).
    [[ -d $PNPM_HOME ]] && path=("$PNPM_HOME" $path)
    # Appended so a stale ~/.bun/bin/bun cannot shadow the Nix bun.
    path+=("$BUN_INSTALL/bin")

    # completionInit's (#q…) glob needs EXTENDED_GLOB before compinit.
    setopt extended_glob
    zmodload zsh/terminfo
  '';
}
