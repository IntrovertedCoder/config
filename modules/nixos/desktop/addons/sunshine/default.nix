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
      openFirewall = false;
      capSysAdmin = true;
    };
    networking.firewall.interfaces = lib.plusultra.openOnLan config {
      tcp = [ 47984 47989 47990 48010 ];
      udp = [ 47998 47999 48000 8000 8001 8002 8003 8004 8005 8006 8007 8008 8010 ];
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
