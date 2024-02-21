{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.obs;
in
{
  options.plusultra.apps.obs= with types; {
    enable = lib.plusultra.mkBoolOpt false "Whether or not to enable obs.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ obs-studio];
    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
    security.polkit.enable = true;
  };
}
