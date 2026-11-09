{ config, lib, ... }:

# Fails evaluation unless the generated .zshrc has compinit, fzf-tab,
# zsh-autosuggestions and fast-syntax-highlighting in that order (fzf-tab hooks
# completion; the last two wrap widgets, highlighting last). The positions come
# from Home Manager's undocumented order numbers (compinit 570, autosuggestions
# 700, fast-syntax-highlighting 1200); this notices if a release changes them.
let
  text = config.programs.zsh.initContent;

  # Offset of the first occurrence of `needle` in the generated text, or null.
  indexOf = needle:
    let
      parts = lib.splitString needle text;
    in
    if lib.length parts < 2 then null else lib.stringLength (lib.head parts);

  stages = map (s: s // { pos = indexOf s.needle; }) [
    { name = "compinit"; needle = "autoload -Uz compinit"; }
    { name = "fzf-tab"; needle = "fzf-tab.plugin.zsh"; }
    { name = "zsh-autosuggestions"; needle = "zsh-autosuggestions.zsh"; }
    { name = "fast-syntax-highlighting"; needle = "fast-syntax-highlighting.plugin.zsh"; }
  ];

  pairs = lib.zipLists (lib.init stages) (lib.tail stages);

  outOfOrder = lib.filter
    (p: p.fst.pos == null || p.snd.pos == null || p.fst.pos >= p.snd.pos)
    pairs;
in
{
  assertions = [
    {
      assertion = outOfOrder == [ ];
      message =
        if outOfOrder == [ ] then
          "zsh plugin order is correct"
        else
          let
            p = lib.head outOfOrder;
          in
          "home/zsh/order-check.nix: the generated .zshrc must contain ${p.fst.name} before ${p.snd.name} "
          + "(required order: compinit, fzf-tab, zsh-autosuggestions, fast-syntax-highlighting); "
          + "it is missing or out of order.";
    }
  ];
}
