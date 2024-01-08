{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.apps.home.discord;
in
{
  options.plusultra.apps.home.discord = with types; {
    enable = mkBoolOpt false "Whether or not to enable Discord.";
  };

  config = mkIf (cfg.enable) {
    plusultra.home.extraOptions = {
      home.packages = with pkgs; [
        (discord.override {withOpenASAR = false; withVencord = false;})
      ];
    };
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "wdiscord" ''
        exec ${pkgs.discord}/bin/discord --enable-features=UseOzonePlatform --ozone-platform=wayland
      '')
    ];
  };
}
