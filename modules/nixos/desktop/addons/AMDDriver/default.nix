{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.addons.AMDDriver;
in
{
  options.plusultra.desktop.addons.AMDDriver = with types; {
    enable = mkBoolOpt false "Whether or not to enable AMDDriver.";
  };

  config = mkIf cfg.enable {
    hardware.opengl.extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
      amdvlk
      libvdpau-va-gl # Hardare Accelerated Video Playback
    ];
    hardware.opengl.driSupport = true;
    hardware.opengl.driSupport32Bit = true;
    hardware.opengl.enable = true;
  };
}
