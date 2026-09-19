{ config, userConfig, ... }:

{
  programs.git.enable = true;
  programs.git.settings.user = {
    name = userConfig.git.name;
    email = userConfig.git.email;
  };

  programs.ghostty = {
    enable = true;
    package = null;
    clearDefaultKeybinds = true;
    settings = {
      background = "000000";
      font-size = 17;
    };
  };

  programs.bat.enable = true;
  programs.btop.enable = true;

  programs.bun = {
    enable = true;
    enableGitIntegration = false;
  };

  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    # Keep the custom aliases in the Zsh module instead of HM's defaults.
    enableZshIntegration = false;
  };

  programs.fd.enable = true;
  programs.go.enable = true;

  programs.ripgrep.enable = true;
  programs.uv.enable = true;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true; # eval "$(fzf --zsh)"  (HM order 910)
    defaultOptions = [ "--height 40%" "--layout=reverse" "--border" "--info=inline" ];
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
    fileWidget.command = config.programs.fzf.defaultCommand; # FZF_CTRL_T_COMMAND
    # older home-manager: fileWidgetCommand = config.programs.fzf.defaultCommand;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd" "cd" ]; # replaces `alias cd=z`, gives `cdi`
  };

}
