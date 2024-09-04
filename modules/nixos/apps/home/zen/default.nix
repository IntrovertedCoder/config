{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.zen;
in
{
  options.plusultra.apps.home.zen = with types; {
    enable = mkBoolOpt false "Whether or not to enable zen.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ zen ];
    plusultra.home.extraOptions.home.packages = with pkgs.plusultra; [ zen ];
  };
}
