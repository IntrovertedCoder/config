{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.steam;
in
{
  options.plusultra.apps.home.steam = with types; {
    enable = mkBoolOpt false "Whether or not to enable steam.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ steam ];
    # plusultra.home.extraOptions.home.packages = with pkgs; [ steam ];
    programs.steam = {
      enable = true;
    };
  };
}
