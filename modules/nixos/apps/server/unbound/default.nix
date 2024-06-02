{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.apps.server.unbound;
  unboundConf = pkgs.writeText "unbound.conf" (builtins.readFile ./unbound.conf);
  piholeConf = pkgs.writeText "pi-hole.conf" (builtins.readFile ./pi-hole.conf);
  namedRoot = pkgs.writeText "named.root" (builtins.readFile ./named.root);
in
  {
  options.plusultra.apps.server.unbound = with types; {
    enable = mkBoolOpt false "Whether or not to enable unbound container.";
    network = mkOpt str "" "The network id to put this container in.";
    ip = mkOpt str "" "The ip address to apply to the container.";
    version = mkOpt str "" "The container version as found on hub.docker.com.";
  };

  config = mkIf cfg.enable {
    system.activationScripts.unboundFolder = ''
      mkdir /data >/dev/null 2>&1 || true
      mkdir /data/unbound >/dev/null 2>&1 || true
    '';
    virtualisation.oci-containers.containers = {
      unbound = {
        image = "mvance/unbound:${cfg.version}";
        hostname = "unbound";
        autoStart = true;
        # Can be any ip between 172.77.0.1 - 172.77.255.254
        extraOptions = [
          "--network=${cfg.network}"
          "--ip=${cfg.ip}"
        ];
        ports = [
          # "externalPort:internalPort";
          "5335:53/tcp"
          "5335:53/udp"
          "5336:5335/tcp"
          "5336:5335/udp"
        ];
        environment = {
          # variable = "string";
          TZ = "${config.time.timeZone}";
        };
        volumes = [
          # "externalLocation:internalLocation"
          "${unboundConf}:/opt/unbound/etc/unbound/unbound.conf"
          # "${piholeConf}:/opt/unbound/etc/unbound/unbound.conf"
          "${namedRoot}:/opt/unbound/etc/unbound/root.hints"
        ];
      };
    };
  };
}
