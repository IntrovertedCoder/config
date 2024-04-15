{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.mullvad;
in
{
  options.plusultra.apps.home.mullvad = with types; {
    enable = mkBoolOpt false "Whether or not to enable mullvad.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ mullvad ];
    # plusultra.home.extraOptions.home.packages = with pkgs; [ mullvad ];
    services.mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
  };
}
