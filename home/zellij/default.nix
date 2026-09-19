{ ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    attachExistingSession = false;
    exitShellOnExit = false;

    settings = {
      pane_frames = false;
      show_startup_tips = false;
      ui = {
        pane_frames = {
          hide_session_name = true;
        };
      };
    };
  };
}
