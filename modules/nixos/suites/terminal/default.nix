{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.suites.terminal;
in
{
  options.plusultra.suites.terminal = with types; {
    enable = lib.plusultra.mkBoolOpt false "Whether or not to enable terminal configuration.";
  };

  config = mkIf cfg.enable {
    plusultra = {
      apps = {
        home = {
          foot = enabled;
          fish = enabled;
          starship = enabled;
          vim = enabled;
          eza = enabled;
          bat = enabled;
          xcp = enabled;
          zoxide = enabled;
          icat = enabled;
        };
      };
    };
  };
}
