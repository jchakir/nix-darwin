# The author's own values; nothing else in the repo names the user, host or keys.
rec {
  user = "jaw";
  home = "/Users/${user}";
  hostname = "jmac"; # flake output name
  fullName = "Jawad"; # shown on the lock screen
  git = {
    name = "Jawad CHAKIR";
    email = "jchakir.pro@gmail.com";
  };
  # Key file names under ~/.ssh
  ssh = {
    default = "id_ed25519";
    github = "id_ed25519-github";
    githubSag = "id_ed25519-github-sag";
  };
}
