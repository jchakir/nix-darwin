{ config, lib, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  # The native module otherwise generates an init.lua for provider setup,
  # which conflicts with the repository-managed config directory.
  xdg.configFile."nvim/init.lua".enable = lib.mkForce false;

  home.activation.linkNvimConfig = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    nvimConfig=${lib.escapeShellArg "${config.home.homeDirectory}/nix-darwin/home/nvim/config"}
    nvimTarget="$HOME/.config/nvim"

    run mkdir -p "$HOME/.config"

    if [[ -L "$nvimTarget" ]]; then
      currentTarget="$(readlink "$nvimTarget")"
      if [[ "$currentTarget" != "$nvimConfig" ]]; then
        run rm "$nvimTarget"
      fi
    elif [[ -e "$nvimTarget" ]]; then
      errorEcho "Cannot link $nvimTarget: an existing file or directory is not a symlink."
      exit 1
    fi

    if [[ ! -L "$nvimTarget" ]]; then
      run ln -s "$nvimConfig" "$nvimTarget"
    fi
  '';
}
