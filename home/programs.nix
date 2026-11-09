{ config, userConfig, ... }:

{
  programs.direnv = {
    nix-direnv.enable = true;
    config.global.hide_env_diff = true;
  };

  programs.git.settings.user = {
    name = userConfig.git.name;
    email = userConfig.git.email;
  };

  programs.ghostty = {
    package = null;
    clearDefaultKeybinds = false;
    settings = {
      background = "000000";
      font-size = 17;
    };
  };

  programs.bun.enableGitIntegration = false;

  programs.dircolors.enableZshIntegration = true;

  # Aliases live in home/zsh/aliases.nix.
  programs.eza.enableZshIntegration = false;

  programs.fzf = {
    enableZshIntegration = true; # sources key-bindings.zsh and completion.zsh (HM order 910)
    defaultOptions = [ "--height 40%" "--layout=reverse" "--border" "--info=inline" ];
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
    fileWidget.command = config.programs.fzf.defaultCommand; # FZF_CTRL_T_COMMAND
  };

  programs.zoxide = {
    enableZshIntegration = true;
    options = [ "--cmd" "cd" ]; # replaces `alias cd=z`, gives `cdi`
  };
}
