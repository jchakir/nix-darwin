{ config, lib, repoPath, ... }:

let
  nvimConfig = "${repoPath}/home/nvim/config";
in
{
  programs.neovim = {
    defaultEditor = true;
    vimAlias = true;
  };

  # Otherwise the module writes an init.lua inside the linked directory.
  xdg.configFile."nvim/init.lua".enable = lib.mkForce false;

  # Out-of-store link into the checkout: Lua edits need no rebuild.
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink nvimConfig;

  # A wrong repoPath would leave a dangling link; fail instead.
  home.activation.checkRepoPath = lib.hm.dag.entryBefore [ "writeBoundary" ] ''
    [[ -d ${lib.escapeShellArg nvimConfig} ]] || { errorEcho ${lib.escapeShellArg "repoPath ${repoPath} has no home/nvim/config; fix repoPath in flake.nix"}; exit 1; }
  '';
}
