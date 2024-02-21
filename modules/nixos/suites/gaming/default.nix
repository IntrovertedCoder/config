{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.suites.gaming;
in
{
  options.plusultra.suites.gaming = with types; {
    enable = lib.plusultra.mkBoolOpt false "Whether or not to enable gaming configuration.";
  };

  config = mkIf cfg.enable {
    plusultra = {
      apps = {
        home = {
          steam = enabled;
          heroic = enabled;
          mangohud = enabled;
        };
      };
    };
  };
}
