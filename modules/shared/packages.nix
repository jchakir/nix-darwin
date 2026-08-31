{ pkgs, ... }:

{
  # allow install of closed source packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.neovim
    pkgs.obsidian
    pkgs.firefox
    pkgs.brave
    pkgs.zip
    pkgs.unzip
    pkgs.zoxide
    pkgs.fzf
    pkgs.eza
    pkgs.ripgrep
    pkgs.bat
    pkgs.fd
    pkgs.btop
    pkgs.superfile
    pkgs.zellij
    pkgs.curl
    pkgs.wget
    pkgs.unzip
    pkgs.zsh
  ];
}
