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
    version = mkOpt str "" "The container version as found on hub.docker.com";
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
        image = "pihole/pihole:${cfg.version}";
        hostname = "pi.hole";
        autoStart = true;
        # Can be any ip between 172.77.0.1 - 172.77.255.254
        extraOptions = [
          "--network=${cfg.network}"
          "--ip=${cfg.ip}"
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
          FTLCONF_LOCAL_IPV4 = "192.168.0.77";
          WEBPASSWORD = "password";
          PIHOLE_DNS_ = "1.1.1.1;1.0.0.1";
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
