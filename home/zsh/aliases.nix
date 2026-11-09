{ ... }:

let
  ezaTreeExcl = "--git-ignore";
in
{
  programs.zsh.shellAliases = {
    ls = "eza --icons --group-directories-first";
    ll = "eza -l --icons --git --group-directories-first";
    la = "eza -la --icons --git --group-directories-first";
    lt = "eza --tree --icons --level=2 ${ezaTreeExcl}";
    lat = "eza -a --tree --icons --level=2 ${ezaTreeExcl}";
    ltt = "eza --tree --icons --level=3 ${ezaTreeExcl}";
    latt = "eza -a --tree --icons --level=3 ${ezaTreeExcl}";

    cat = "bat --paging=never";
    grep = "rg";
    find = "fd";
    top = "btop";

    # Opens home/zsh/ through the ~/.config/nvim link into the repo
    # (nonexistent path if the link is missing).
    zshrc = ''$EDITOR "$(readlink ~/.config/nvim)/../../zsh"'';
    reload = "exec zsh";
    path = "print -l $path";
    d = "dirs -v";
  };
}
