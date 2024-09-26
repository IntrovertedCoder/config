{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.zen;
in
{
  options.plusultra.apps.home.zen = with types; {
    enable = mkBoolOpt false "Whether or not to enable zen.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mpv
      openh264
    ];
    plusultra.home.extraOptions.home.packages = with pkgs.plusultra; [ zen ];
    plusultra.home.defaultApplications = {
      "x-scheme-handler/http" = [ "userapp-Zen Browser-44LET2.desktop" ];
      "x-scheme-handler/https" = [ "userapp-Zen Browser-44LET2.desktop" ];
      "x-scheme-handler/chrome" = [ "userapp-Zen Browser-44LET2.desktop" ];
      "text/html/chrome" = [ "userapp-Zen Browser-44LET2.desktop" ];
      "application/x-extension-htm" = [ "userapp-Zen Browser-44LET2.desktop" ];
      "application/x-extension-html" = [ "userapp-Zen Browser-44LET2.desktop" ];
      "application/x-extension-shtml" = [ "userapp-Zen Browser-44LET2.desktop" ];
      "application/xhtml+xml" = [ "userapp-Zen Browser-44LET2.desktop" ];
      "application/x-extension-xhtml" = [ "userapp-Zen Browser-44LET2.desktop" ];
      "application/x-extension-xht" = [ "userapp-Zen Browser-44LET2.desktop" ];
    };
  };
}
