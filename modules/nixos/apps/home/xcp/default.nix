{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.xcp;
in
{
  options.plusultra.apps.home.xcp = with types; {
    enable = mkBoolOpt false "Whether or not to enable xcp.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions = {
      programs = {
        fish.functions = mkIf config.plusultra.apps.home.fish.enable {
          cp = "xcp $argv";
        };
      };
      home.packages = with pkgs; [
        xcp
      ];
    };
  };
}
