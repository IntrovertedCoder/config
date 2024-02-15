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

      "audio/x-xm" = [ "vlc.desktop" ];
      "audio/x-s3m" = [ "vlc.desktop" ];
      "audio/x-mod" = [ "vlc.desktop" ];
      "audio/x-it" = [ "vlc.desktop" ];
      "audio/x-wavpack" = [ "vlc.desktop" ];
      "audio/x-tta" = [ "vlc.desktop" ];
      "audio/x-musepack" = [ "vlc.desktop" ];
      "audio/x-gsm" = [ "vlc.desktop" ];
      "audio/x-ape" = [ "vlc.desktop" ];
      "audio/midi" = [ "vlc.desktop" ];
      "audio/basic" = [ "vlc.desktop" ];
      "audio/vnd.dts.hd" = [ "vlc.desktop" ];
      "audio/vnd.dts" = [ "vlc.desktop" ];
      "audio/ac3" = [ "vlc.desktop" ];
      "audio/x-adpcm" = [ "vlc.desktop" ];
      "audio/vnd.wave" = [ "vlc.desktop" ];
      "audio/x-aiff" = [ "vlc.desktop" ];
      "audio/x-scpls" = [ "vlc.desktop" ];
      "audio/mpegurl" = [ "vlc.desktop" ];
      "audio/AMR-WB" = [ "vlc.desktop" ];
      "audio/AMR" = [ "vlc.desktop" ];
      "audio/webm" = [ "vlc.desktop" ];
      "audio/x-matroksa" = [ "vlc.desktop" ];
      "audio/mp4" = [ "vlc.desktop" ];
      "audio/aac" = [ "vlc.desktop" ];
      "audio/mp2" = [ "vlc.desktop" ];
      "audio/mpeg" = [ "vlc.desktop" ];
      "audio/vnd.rn-realaudio" = [ "vlc.desktop" ];
      "audio/x-ms-wma" = [ "vlc.desktop" ];
      "audio/flac" = [ "vlc.desktop" ];
      "audio/x-speex" = [ "vlc.desktop" ];
      "audio/x-vorbis+ogg" = [ "vlc.desktop" ];
      "audio/ogg" = [ "vlc.desktop" ];

      "x-content/audio-player" = [ "vlc.desktop" ];
      "x-content/audio-cdda" = [ "vlc.desktop" ];
      "x-content/video-dvd" = [ "vlc.desktop" ];
      "x-content/video-svcd" = [ "vlc.desktop" ];
      "x-content/video-vcd" = [ "vlc.desktop" ];

      "application/mxf" = [ "vlc.desktop" ];
      "application/vnd.adobe.flash.movie" = [ "vlc.desktop" ];
      "application/x-shorten" = [ "vlc.desktop" ];
      "application/sdp" = [ "vlc.desktop" ];
      "application/vnd.ms-wpl" = [ "vlc.desktop" ];
      "application/vnd.apple.mpegurl" = [ "vlc.desktop" ];
      "application/xspf+xml" = [ "vlc.desktop" ];
      "application/ram" = [ "vlc.desktop" ];
      "application/vnd.efi.iso" = [ "vlc.desktop" ];
      "application/x-matroksa" = [ "vlc.desktop" ];
      "application/x-quicktime-media-link" = [ "vlc.desktop" ];
      "application/vnd.rn-realmedia" = [ "vlc.desktop" ];
      "application/vnd.ms-asf" = [ "vlc.desktop" ];
      "application/ogg" = [ "vlc.desktop" ];
    };
  };
}
