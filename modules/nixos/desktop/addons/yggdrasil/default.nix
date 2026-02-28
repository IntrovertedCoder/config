{ options, config, lib, pkgs, ... }:

with lib;
# Assuming lib.plusultra contains mkBoolOpt, otherwise you can use standard mkOption
with lib.plusultra;
let
  cfg = config.plusultra.desktop.addons.yggdrasil;

  # Helper function to generate ip6tables rules for specific private IPs
  mkPrivateRules = proto: ports:
    concatMapStrings (ip:
      concatMapStrings (port: ''
        ip6tables -w -I nixos-fw -i ygg0 -s ${ip} -p ${proto} --dport ${toString port} -j nixos-fw-accept
      '') ports
    ) cfg.privatePeers;
in
{
  options.plusultra.desktop.addons.yggdrasil = with types; {
    enable = mkBoolOpt false "Whether or not to enable Yggdrasil.";

    peers = mkOption {
      type = listOf str;
      default = [];
      description = "List of public/initial peers to connect to.";
    };

    allowedTCPPorts = mkOption {
      type = listOf int;
      default = [];
      description = "TCP ports allowed for ALL incoming Yggdrasil connections.";
    };

    allowedUDPPorts = mkOption {
      type = listOf int;
      default = [];
      description = "UDP ports allowed for ALL incoming Yggdrasil connections.";
    };

    privatePeers = mkOption {
      type = listOf str;
      default = [];
      description = "List of specific Yggdrasil IPs (IPv6) allowed to access private ports.";
    };

    privateTCPPorts = mkOption {
      type = listOf int;
      default = [];
      description = "TCP ports allowed ONLY for the specific IPs in privatePeers.";
    };

    privateUDPPorts = mkOption {
      type = listOf int;
      default = [];
      description = "UDP ports allowed ONLY for the specific IPs in privatePeers.";
    };
  };

  config = mkIf cfg.enable {
    services.yggdrasil = {
      enable = true;
      persistentKeys = true; # Automatically generates and keeps keys in /var/lib/yggdrasil/keys.json
      openMulticastPort = true; # Helps with local peer discovery
      settings = {
        Peers = cfg.peers;
        IfName = "ygg0"; # Force interface name so our firewall rules predictably match
        AdminListen = "unix:///var/run/yggdrasil/yggdrasil.sock";
      };
    };

    # 1. Base rules for ALL Yggdrasil IPs
    networking.firewall.interfaces."ygg0" = {
      allowedTCPPorts = cfg.allowedTCPPorts;
      allowedUDPPorts = cfg.allowedUDPPorts;
    };

    # 2. Specific rules for PRIVATE Yggdrasil IPs via extraCommands
    # This appends to the default 'nixos-fw' chain
    networking.firewall.extraCommands = ''
      # Log dropped Yggdrasil packets specifically (Limited to 5 per minute to avoid log spam)
      ip6tables -w -A nixos-fw -i ygg0 -m limit --limit 5/min -j LOG --log-prefix "YGG-DROP: "

      ${mkPrivateRules "tcp" cfg.privateTCPPorts}
      ${mkPrivateRules "udp" cfg.privateUDPPorts}
    '';

    services.fail2ban = {
      enable = true;
      maxretry = 5;
      ignoreIP = [ "::1" "fe80::/10" ] ++ cfg.privatePeers; # Don't ban yourself or your private peers
      jails = {
        # Custom jail to watch the Yggdrasil interface specifically
        yggdrasil-proto = ''
          enabled = true
          port = 0:65535
          filter = nosshd
          logpath = /var/log/messages
          backend = systemd
          maxretry = 10
          findtime = 600
          bantime = 3600
        '';
      };
    };
  };
}
