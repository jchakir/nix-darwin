{ lib, ... }:

{
  # /etc/zshrc runs before every user's .zshrc, root's and Apple's /bin/zsh
  # included. The user's .zshrc does its own compinit and prompt, so skip them.
  # programs.zsh.enable stays on: turning it off drops the Nix PATH from every zsh.
  programs.zsh = {
    enableGlobalCompInit = false;
    enableBashCompletion = false;
    promptInit = "";
  };

  # No `brew shellenv` at every shell start: it forks a process and puts Homebrew
  # ahead of Nix. Put Homebrew on PATH statically instead, after the Nix profiles
  # (order 1000) and before /usr/bin (1200). HOMEBREW_* variables no longer reach
  # the shell; `brew` sets its own.
  nix-homebrew.enableZshIntegration = false;
  environment.systemPath = lib.mkOrder 1100 [
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
  ];
}
