{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.virtmanager;
in
{
  options.plusultra.apps.virtmanager = with types; {
    enable = mkBoolOpt false "Whether or not to enable virtmanager.";
  };

  config = mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    plusultra = {
      user.extraGroups = [ "libvirtd" "kvm" ];
      home.extraOptions.dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = ["qemu:///system"];
          uris = ["qemu:///system"];
        };
      };
    };
  };
}
