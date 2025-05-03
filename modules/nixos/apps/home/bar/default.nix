{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.bar;
in
{
  options.plusultra.apps.home.bar = with types; {
    enable = mkBoolOpt false "Whether or not to enable bar.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ bar ];
    plusultra.home.extraOptions.home.packages = with pkgs; [ beyond-all-reason ];
  };
}
