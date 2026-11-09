{ config, ... }:

{
  programs.zsh = {
    history = {
      size = 50000;
      save = 50000;
      path = "${config.home.homeDirectory}/.zsh_history";
      share = true;
      ignoreSpace = true;
      ignoreAllDups = true;
      saveNoDups = true;
      findNoDups = true;
      expireDuplicatesFirst = true;
      extended = true;
    };

    setOptions = [
      "HIST_REDUCE_BLANKS"
      "HIST_VERIFY"
    ];
  };
}
