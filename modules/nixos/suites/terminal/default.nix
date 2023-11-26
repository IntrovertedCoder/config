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
          alacritty = enabled;
          fish = enabled;
          starship = enabled;
          vim = enabled;
          exa = enabled;
          bat = enabled;
          xcp = enabled;
          zoxide = enabled;
        };
      };
    };
  };
}
