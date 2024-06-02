{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.server.unbound;
in
{
  options.plusultra.apps.server.unbound = with types; {
    enable = mkBoolOpt false "Whether or not to enable unbound container.";
    network = mkOpt str "" "The network id to put this container in.";
    ip = mkOpt str "" "The ip address to apply to the container.";
  };

  config = mkIf cfg.enable {
    system.activationScripts.piholeFolder = ''
      mkdir /data >/dev/null 2>&1 || true
      mkdir /data/unbound >/dev/null 2>&1 || true
    '';
    virtualisation.oci-containers.containers = {
      unbound = {
        image = "mvance/unbound:1.12.0";
        hostname = "unbound";
        autoStart = true;
        # Can be any ip between 172.77.0.1 - 172.77.255.254
        extraOptions = [
          "--network=${cfg.network}"
          "--ip=${cfg.ip}"
        ];
        ports = [
          # "externalPort:internalPort";
          "535:53/tcp"
          "535:53/udp"
        ];
        environment = {
          # variable = "string";
          TZ = "${config.time.timeZone}";
        };
        volumes = [
          # "externalLocation:internalLocation"
        ];
      };
    };
  };
}
