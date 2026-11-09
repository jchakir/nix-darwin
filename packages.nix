# The one package file: every tool and app is named here, once per way it is
# installed. Data only; it takes `pkgs`.
#
# Placement rule
#   * no Home Manager module in this repo -> `system`
#   * has a Home Manager module           -> `homeTools` (the user's profile, so root does not get it)
#   * GUI app                             -> `homebrew.casks`
#   * font                                -> `fonts`
#   * CLI tool the Nix cache cannot give  -> `homebrew.brews` (nothing compiled here)
#
# `homebrew.taps` hold strings or { name = "..."; trusted = true; };
# `homebrew.cleanup` is read as "none" when absent.
{ pkgs }:

{
  system = with pkgs; [
    curl
    wget
    zip
    unzip
    podman
    podman-compose
    superfile
    rtk
    fnm
    pnpm
    zsh-completions
    bandwhich
    duf
    typst
    mas
  ];

  fonts = [ pkgs.font-awesome ];

  # Only switches tools on (programs.<name>.enable, in home/default.nix).
  # Their settings go in home/programs.nix or a tool folder under home/.
  homeTools = [
    "direnv"
    "git"
    "ghostty"
    "bat"
    "btop"
    "bun"
    "dircolors"
    "eza"
    "fd"
    "go"
    "ripgrep"
    "uv"
    "fzf"
    "zoxide"
    "zsh"
    "ssh"
    "neovim"
    "zellij"
    "oh-my-posh"
    "claude-code"
  ];

  homebrew = {
    taps = [ ];
    brews = [ ];
    casks = [
      "the-unarchiver"
      "ghostty"
      "obsidian"
      "brave-browser"
      "spotify"
      "claude"
      "telegram"
      "whatsapp"
      "paseo"
      "vorssaint"
    ];
    cleanup = "uninstall";
  };
}
