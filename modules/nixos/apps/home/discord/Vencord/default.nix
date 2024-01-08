{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.discord.Vencord;
in
{
  options.plusultra.apps.home.discord.Vencord = with types; {
    enable = mkBoolOpt false "Whether or not to enable Vencord.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions = {
      home.packages = with pkgs; [
        (discord.override {withOpenASAR = false; withVencord = true;})
      ];
    };
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "wdiscord" ''
        exec ${pkgs.discord{withOpenASAR = false; withVencord = true;}}/bin/discord --enable-features=UseOzonePlatform --ozone-platform=wayland
      '')
    ];
  };
}
