{ pkgs, ... }:

let
  omz = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
in
{
  programs.zsh = {
    autosuggestion = {
      enable = true; # sourced at order 700
      strategy = [ "history" "completion" ];
    };

    fastSyntaxHighlighting.enable = true; # sourced at order 1200

    historySubstringSearch.enable = true; # sourced at order 1250, binds ^[[A / ^[[B

    # Sourced straight from the oh-my-zsh package (order 900): no framework, no
    # second compinit. The two lib files are helpers for git and copypath.
    plugins = [
      { name = "omz-lib-git"; src = "${omz}/lib"; file = "git.zsh"; }
      { name = "omz-lib-clipboard"; src = "${omz}/lib"; file = "clipboard.zsh"; }
      { name = "git"; src = "${omz}/plugins/git"; }
      { name = "sudo"; src = "${omz}/plugins/sudo"; }
      { name = "extract"; src = "${omz}/plugins/extract"; }
      { name = "copypath"; src = "${omz}/plugins/copypath"; }
    ];

    # Set before the plugins are sourced (order 540).
    localVariables = {
      ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE = "20";
      HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE = "1";
    };
  };
}
