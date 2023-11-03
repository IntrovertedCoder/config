{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.bat;
in
{
  options.plusultra.apps.home.bat = with types; {
    enable = mkBoolOpt false "Whether or not to enable bat.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions = {
      programs = {
        fish.functions = mkIf config.plusultra.apps.home.fish.enable {
          cat = "bat $argv";
        };
      };
      home.packages = with pkgs; [
        bat
      ];
    };
  };
}
