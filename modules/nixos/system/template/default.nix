{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.system.template;
in
{
  options.plusultra.system.template = with types; {
    enable = mkBoolOpt false "Whether or not to enable template.";
    str = mkOpt str "" "Additional configuration";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ template ];
  };
}
