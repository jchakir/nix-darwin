{ lib, userConfig, ... }:

{
  programs.ssh = {
    enableDefaultConfig = false;

    settings = {
      "github-sag" = lib.hm.dag.entryBefore [ "github.com" ] {
        IdentityFile = "~/.ssh/${userConfig.ssh.githubSag}";
        User = "git";
        HostName = "github.com";
      };

      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/${userConfig.ssh.github}";
      };

      "*" = {
        AddKeysToAgent = "yes";
        IdentitiesOnly = "yes";
        IdentityFile = "~/.ssh/${userConfig.ssh.default}";
      };
    };
  };
}
