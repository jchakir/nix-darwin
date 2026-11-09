{ userConfig, ... }:

{
  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;

    finder.AppleShowAllExtensions = true;
    finder.AppleShowAllFiles = true;
    finder.FXPreferredViewStyle = "clmv";
    finder.FXRemoveOldTrashItems = true;
    finder.ShowStatusBar = true;

    # Set explicitly: deleting the key would leave the live value in place.
    loginwindow.GuestEnabled = false;
    loginwindow.LoginwindowText = userConfig.fullName;

    NSGlobalDomain.AppleICUForce24HourTime = false;
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    NSGlobalDomain.KeyRepeat = 2;
  };
}
