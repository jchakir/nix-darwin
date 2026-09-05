{ inputs, userConfig, ... }:

{
  imports = [ inputs.home-manager.darwinModules.home-manager ];

  users.knownUsers = [ userConfig.user ];
  users.users.${userConfig.user} = {
    name = userConfig.user;
    home = userConfig.home;
    uid = userConfig.uid;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs userConfig; };
    users.${userConfig.user} = import ../../home;
  };
}
