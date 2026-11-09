{ config, pkgs, ... }:

{
  programs.zsh = {
    enableCompletion = true;

    # Without -C only when the dump is missing or over 24 h old, and even then
    # it rebuilds only if the completion files or zsh version changed: delete
    # ~/.zcompdump* to see a new completion sooner. -u skips the "insecure
    # directories" prompt for Homebrew paths.
    # fzf-tab goes right after compinit, before widget-wrapping plugins (700).
    completionInit = ''
      autoload -Uz compinit
      _zcd="''${ZDOTDIR:-$HOME}/.zcompdump"
      if [[ ! -f $_zcd || -n $_zcd(#qN.mh+24) ]]; then
        compinit -u -d "$_zcd"
      else
        compinit -C -d "$_zcd"
      fi
      unset _zcd

      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
    '';

    initContent = ''
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "${config.xdg.cacheHome}/zsh/.zcompcache"
      # case-insensitive first, then partial-word fallback
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no                     # let fzf-tab own the menu
      zstyle ':completion:*' verbose yes
      zstyle ':completion:*' group-name ""
      zstyle ':completion:*:descriptions' format '[%d]'  # plain text — fzf-tab requirement
      zstyle ':completion:*:warnings'     format '── no matches ──'
      zstyle ':fzf-tab:*' switch-group '<' '>'
      zstyle ':fzf-tab:complete:cd:*' fzf-preview \
        'eza -1 --color=always --icons $realpath 2>/dev/null || ls --color $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview \
        'eza -1 --color=always --icons $realpath 2>/dev/null || ls --color $realpath'
    '';
  };
}
