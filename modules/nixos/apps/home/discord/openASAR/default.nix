{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.discord.openASAR;
in
{
  options.plusultra.apps.home.discord.openASAR= with types; {
    enable = mkBoolOpt false "Whether or not to enable discord/openASAR.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions = {
      home.packages = with pkgs; [
        (discord.override {withOpenASAR = true; withVencord = false;})
      ];
    };
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "wdiscord" ''
        exec ${pkgs.discord{withOpenASAR = true; withVencord = false;}}/bin/discord --enable-features=UseOzonePlatform --ozone-platform=wayland
      '')
    ];
  };
}
