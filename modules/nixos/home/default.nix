{ options, config, pkgs, lib, inputs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.home;
in
{
  # imports = with inputs; [
  #   home-manager.nixosModules.home-manager
  # ];

  options.plusultra.home = with types; {
    file = mkOpt attrs { }
      (mdDoc "A set of files to be managed by home-manager's `home.file`.");
    configFile = mkOpt attrs { }
      (mdDoc "A set of files to be managed by home-manager's `xdg.configFile`.");
    extraOptions = mkOpt attrs { } "Options to pass directly to home-manager.";
    defaultApplications = mkOpt attrs { } "Options to pass directly to xdg.mimeApps.defaultApplications.";
  };

  config = {
    plusultra.home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.plusultra.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.plusultra.home.configFile;
      xdg.mimeApps.enable = true;
      xdg.mimeApps.defaultApplications = mkAliasDefinitions options.plusultra.home.defaultApplications;
    };

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;

      users.${config.plusultra.user.name} =
        mkAliasDefinitions options.plusultra.home.extraOptions;
    };
  };
}
