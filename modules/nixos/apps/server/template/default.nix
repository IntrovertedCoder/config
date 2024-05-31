{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.server.template;
in
{
  options.plusultra.apps.server.template = with types; {
    enable = mkBoolOpt false "Whether or not to enable template.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ template];
  };
}
