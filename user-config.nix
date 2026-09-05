rec {
  user = "jaw";
  uid = 502; # must match the existing macOS account (dscl UniqueID), to get it run: id -u $(whoami)
  home = "/Users/${user}";
  hostname = "jmac";
  fullName = "Jawad"; # name in lock screen
  git = {
    name = "Jawad CHAKIR";
    email = "jchakir.pro@gmail.com";
  };
}
