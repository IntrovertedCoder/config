{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.apps.home.obsidian;
in
{
  options.plusultra.apps.home.obsidian = with types; {
    enable = mkBoolOpt false "Whether or not to enable Discord.";
  };

  config = mkIf (cfg.enable) {
    plusultra.home.extraOptions = {
      home.packages = with pkgs; [
        obsidian
      ];
    };
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "wobsidian" ''
        exec ${pkgs.obsidian}/bin/obsidian --enable-features=UseOzonePlatform --ozone-platform=wayland --disable-gpu
      '')
    ];
  };
}
