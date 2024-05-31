{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.server.samba;
in
{
  options.plusultra.apps.server.samba = with types; {
    enable = mkBoolOpt false "Whether or not to enable samba.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ samba];
    services.samba = {
      enable = true;
      package = pkgs.sambaFull;
      securityType = "user";
      openFirewall = true;
      extraConfig = ''
        server string = ${config.networking.hostName}
        netbios name = ${config.networking.hostName}
        workgroup = WORKGROUP
        security = user

        create mask = 0664
        force create mode = 0664
        directory mask = 0775
        force directory mode = 0775
        follow symlinks = yes

        # :NOTE| localhost is the ipv6 localhost ::1
        hosts allow = 192.168.0.0/16 localhost
        hosts deny = 0.0.0.0/0
        guest account = nobody
        map to guest = bad user
      '';
      shares = {
        data = {
          path = "/data";
          browseable = "yes";
          "read only" = "yes";
          "guest ok" = "no";
          "force user" = "${config.plusultra.user.name}";
          # "force group" = "samba-group";
          "write list" = "${config.plusultra.user.name}";
        };
        share = {
          path = "/data/share";
          browseable = "yes";
          "read only" = "yes";
          "guest ok" = "no";
          "force user" = "${config.plusultra.user.name}";
          # "force group" = "samba-group";
          "write list" = "${config.plusultra.user.name}";
        };
        printers = {
          comment = "All printers";
          path = "/var/spool/samba";
          public = "yes";
          browsable = "yes";
          "guest ok" = "yes";
          writable = "no";
          printable = "yes";
          "create mode" = 0700;
        };
      };
    };
  };
}
