{ inputs, userConfig, packagesFile, repoPath, ... }:

{
  imports = [ inputs.home-manager.darwinModules.home-manager ];

  users.users.${userConfig.user} = {
    name = userConfig.user;
    home = userConfig.home;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs userConfig packagesFile repoPath; };
    users.${userConfig.user} = import ../home;
  };
}
