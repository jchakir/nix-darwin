{ ... }:

{
  programs.zsh.initContent = ''
    bindkey "''${terminfo[kLFT5]:-^[[1;5D}" backward-word
    bindkey "''${terminfo[kRIT5]:-^[[1;5C}" forward-word
    bindkey "''${terminfo[khome]:-^[[H}"   beginning-of-line
    bindkey "''${terminfo[kend]:-^[[F}"    end-of-line
    bindkey "''${terminfo[kdch1]:-^[[3~}"  delete-char

    # Ctrl-X Ctrl-E edits the command line in $EDITOR
    autoload -Uz edit-command-line; zle -N edit-command-line
    bindkey '^X^E' edit-command-line

    # bash-style word boundaries: Ctrl-w / Alt-b / Alt-f stop at / and .
    autoload -Uz select-word-style && select-word-style bash
  '';
}
