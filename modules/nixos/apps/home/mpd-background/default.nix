{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.apps.home.mpd-background;
  mpd-background-Conf = pkgs.writeText "mpd-background.conf" ''
    music_directory     "/home/${config.plusultra.user.name}/Music"
    playlist_directory  "/home/${config.plusultra.user.name}/.config/mpd-background/playlists"
    db_file             "/home/${config.plusultra.user.name}/.config/mpd-background/database"

    state_file          "/home/${config.plusultra.user.name}/.config/mpd-background/state"
    sticker_file        "/home/${config.plusultra.user.name}/.config/mpd-background/sticker.sql"

    bind_to_address "127.0.0.1"

    port "6601"

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
in
{
  options.plusultra.apps.home.mpd-background = with types; {
    enable = mkBoolOpt false "Whether or not to enable mpd background.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions.home.packages = with pkgs; [ mpc-cli ];
    systemd.user.services.mpd-background = {
      enable = true;
      description = "A second mpd service";
      after = [ "network.target" "sound.target" ];

      wantedBy = [ "default.target" ];

      serviceConfig = {
        Environment = "PATH=/etc/profiles/per-user/${config.plusultra.user.name}/bin";
        ExecStart = "${pkgs.mpd}/bin/mpd --no-daemon ${mpd-background-Conf}";
        Type = "notify";
        ExecStartPre = ''
          ${pkgs.bash}/bin/bash -c "${pkgs.coreutils}/bin/mkdir -p '/home/${config.plusultra.user.name}/.config/mpd-background' '/home/${config.plusultra.user.name}/.config/mpd-background/playlists'"'';
      };
    };
  };
}
