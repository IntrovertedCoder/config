{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.suites.template;
in
{
  options.plusultra.suites.template = with types; {
    enable = lib.plusultra.mkBoolOpt false "Whether or not to enable template configuration.";
  };

  config = mkIf cfg.enable {
    plusultra = {
      apps = {
      };
      home = {
      };
    };
  };
}
