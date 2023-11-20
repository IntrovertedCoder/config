{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.mpd;
in
{
  options.plusultra.apps.home.mpd = with types; {
    enable = mkBoolOpt false "Whether or not to enable mpd.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions.home.packages = with pkgs; [ mpc-cli ];
    plusultra.home.extraOptions.services = {
      mpd = {
        enable = true;
        dataDir = "/home/${config.plusultra.user.name}/.config/mpd";
        dbFile = "/home/${config.plusultra.user.name}/.config/mpd/database";
        playlistDirectory = "/home/${config.plusultra.user.name}/.config/mpd/playlists";
        musicDirectory = "/home/${config.plusultra.user.name}/Music";
        # startWhenNeeded = true;
        extraConfig = ''
          audio_output {
            type  "pipewire"
            name  "PipeWire Sound Server"
          }
          audio_output {
            type    "fifo"
            name    "my_fifo"
            path    "/tmp/mpd.fifo"
            format  "44100:16:2"
          }

          replaygain                "track"
          replaygain_missing_preamp "0"
          replaygain_limit          "yes"
          volume_normalization      "yes"
          '';
      };
    };
  };
}
