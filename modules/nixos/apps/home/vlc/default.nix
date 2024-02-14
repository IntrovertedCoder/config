{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.vlc;
in
{
  options.plusultra.apps.home.vlc = with types; {
    enable = mkBoolOpt false "Whether or not to enable vlc.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ vlc ];
    plusultra.home.extraOptions.home.packages = with pkgs; [ vlc ];
    plusultra.home.defaultApplications = {
      "video/x-flv" = [ "vlc.desktop" ];
      "video/x-vlic" = [ "vlc.desktop" ];
      "video/x-nsv" = [ "vlc.desktop" ];
      "video/x-anim" = [ "vlc.desktop" ];
      "video/dv" = [ "vlc.desktop" ];
      "video/vnd.mpegurl" = [ "vlc.desktop" ];
      "video/3gpp2" = [ "vlc.desktop" ];
      "video/3gpp" = [ "vlc.desktop" ];
      "video/webm" = [ "vlc.desktop" ];
      "video/x-matroska" = [ "vlc.desktop" ];
      "video/quicktime" = [ "vlc.desktop" ];
      "video/mp4" = [ "vlc.desktop" ];
      "video/mpeg" = [ "vlc.desktop" ];
      "video/mp2t" = [ "vlc.desktop" ];
      "video/vnd.rn-realvideo" = [ "vlc.desktop" ];
      "video/avi" = [ "vlc.desktop" ];
      "video/x-ms-wmv" = [ "vlc.desktop" ];
      "video/x-theora+ogg" = [ "vlc.desktop" ];
      "video/x-ogm+ogg" = [ "vlc.desktop" ];
      "video/ogg" = [ "vlc.desktop" ];
    };
  };
}
