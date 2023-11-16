{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.vial;
in
{
  options.plusultra.apps.home.vial = with types; {
    enable = mkBoolOpt false "Whether or not to enable vial.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ vial ];
    plusultra.home.extraOptions.home.packages = with pkgs; [ vial ];
    services.udev.packages = with pkgs; [
      vial
    ];
  };
}
