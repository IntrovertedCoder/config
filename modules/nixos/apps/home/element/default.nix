{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.apps.home.element;
in
{
  options.plusultra.apps.home.element = with types; {
    enable = mkBoolOpt false "Whether or not to enable Element.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions.home.packages = with pkgs; [ element-desktop ];
    environment.systemPackages = [
        (pkgs.writeShellScriptBin "element" ''
            exec ${pkgs.element-desktop}/bin/element-desktop --enable-features=UseOzonePlatform --ozone-platform=wayland
        '')
      ];
  };
}
