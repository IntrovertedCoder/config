{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.server.pihole;
in
{
  options.plusultra.apps.server.pihole = with types; {
    enable = mkBoolOpt false "Whether or not to enable pihole container.";
    network = mkOpt str "" "The network id to put this container in.";
    ip = mkOpt str "" "The ip address to apply to the container.";
  };

  config = mkIf cfg.enable {
    system.activationScripts.piholeFolder = ''
      mkdir /data >/dev/null 2>&1 || true
      mkdir /data/pihole >/dev/null 2>&1 || true
      mkdir /data/pihole/etc-dnsmasq.d >/dev/null 2>&1 || true
      mkdir /data/pihole/etc-pihole >/dev/null 2>&1 || true
    '';
    virtualisation.oci-containers.containers = {
      pihole = {
        image = "pihole/pihole:2024.05.0";
        hostname = "pi.hole";
        autoStart = true;
        # Can be any ip between 172.77.0.1 - 172.77.255.254
        extraOptions = [
          "--network=IridiumNet"
          "--ip=172.77.0.10"
          "--dns=1.1.1.1"
          "--dns=1.0.0.1"
        ];
        ports = [
          "53:53/tcp"
          "53:53/udp"
          "81:80/tcp"
        ];
        environment = {
          # variable = "string";
          TZ = "${config.time.timeZone}";
          VIRTUAL_HOST = "pi.hole";
          PROXY_LOCATION = "pi.hole";
          ServerIP = "192.168.0.77";
          WEBPASSWORD = "password";
        };
        volumes = [
          # "externalLocation:internalLocation"
          "/data/pihole/etc-pihole:/etc/pihole"
          "/data/pihole/etc-dnsmasq.d:/etc/dnsmasq.d"
        ];
      };
    };
  };
}