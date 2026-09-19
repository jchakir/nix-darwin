{ lib, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "github-sag" = lib.hm.dag.entryBefore [ "github.com" ] {
        IdentityFile = "~/.ssh/id_ed25519-github-sag";
        User = "git";
        HostName = "github.com";
      };

      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/id_ed25519-github";
      };

      "*" = {
        AddKeysToAgent = "yes";
        IdentitiesOnly = "yes";
        IdentityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
