{ ... }:

{
  programs.zsh.initContent = ''
    # fnm: --shell skips process-tree detection; recursive finds
    # .nvmrc/.node-version in parent directories.
    if (( $+commands[fnm] )); then
      eval "$(fnm env --use-on-cd --shell zsh --version-file-strategy=recursive --log-level=quiet)"
    fi
  '';
}
