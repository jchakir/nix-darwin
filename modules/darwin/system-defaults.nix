{ userConfig, ... }:

{
  # system settings
  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;

    finder.AppleShowAllExtensions = true;
    finder.AppleShowAllFiles = true;
    finder.FXPreferredViewStyle = "clmv";
    finder.FXRemoveOldTrashItems = true;
    finder.ShowStatusBar = true;

    loginwindow.GuestEnabled = true;
    loginwindow.LoginwindowText = userConfig.fullName;

    NSGlobalDomain.AppleICUForce24HourTime = false;
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    NSGlobalDomain.KeyRepeat = 2;
  };
}
