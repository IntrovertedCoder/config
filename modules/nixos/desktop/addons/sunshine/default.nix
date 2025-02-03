{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.addons.sunshine;
in
{
  options.plusultra.desktop.addons.sunshine = with types; {
    enable = mkBoolOpt false "Whether or not to enable sunshine.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ sunshine ];
    # plusultra.home.extraOptions.home.packages = with pkgs; [ sunshine ];
    services.sunshine = {
      enable = true;
      autoStart = true;
      openFirewall = true;
      capSysAdmin = true;
    };
    # plusultra.desktop.Hyprland.sunshine = "exec-once = while true do; sunshine; end";
    systemd.user.services.sunshine = {
      enable = true;
      after = [ "network.target" ];
      wantedBy = [ "default.target" ];
      startLimitBurst = 5;
      startLimitIntervalSec = 500;
      serviceConfig = {
        Restart = "on-failure";
        RestartSec = "5s";
      };
    };
  };
}
