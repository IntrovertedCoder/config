{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.server.speedtest;
in
{
  options.plusultra.apps.server.speedtest = with types; {
    enable = mkBoolOpt false "Whether or not to enable speedtest container.";
    network = mkOpt str "" "The network id to put this container in.";
    ip = mkOpt str "" "The ip address to apply to the container.";
    version = mkOpt str "" "The container version as found on hub.docker.com";
  };

  config = mkIf cfg.enable {
    system.activationScripts.speedtestFolder = ''
      mkdir /data >/dev/null 2>&1 || true
      mkdir /data/speedtest >/dev/null 2>&1 || true
    '';
    virtualisation.oci-containers.containers = {
      speedtest = {
        image = "linuxserver/speedtest-tracker:${cfg.version}";
        hostname = "speedtest";
        autoStart = true;
        # Can be any ip between 172.77.0.1 - 172.77.255.254
        extraOptions = [
          "--network=${cfg.network}"
          "--ip=${cfg.ip}"
        ];
        ports = [
          # "externalPort:internalPort";
          "8080:80"
          "8443:443"
        ];
        environment = {
          # variable = "string";
          TZ = "${config.time.timeZone}";
          PUID = "1000";
          GUID = "100";
          APP_KEY = "base64:vwGqFYRRGiGgUKbIjzHNwmEBwoXAsseTDxZvuwpnwjk=";
          SPEEDTEST_SCHEDULE = "0,30 * * * *";
        };
        volumes = [
          # "externalLocation:internalLocation"
          "/data/speedtest:/config"
        ];
      };
    };
  };
}
