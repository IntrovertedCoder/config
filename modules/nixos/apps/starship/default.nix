{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.starship;
in
{
  options.plusultra.apps.starship = with types; {
    enable = mkBoolOpt false "Whether or not to enable starship.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions.programs.starship = {
       enable = true;
       enableFishIntegration = true;
       settings = {
         add_newline = false;

         right_format = "$status $memory_usage $cmd_duration $sudo";

         character = {
           success_symbol = "[➜](${config.plusultra.color.Green})";
           error_symbol = "[✗](${config.plusultra.color.Red})";
         };

         git_commit = {
           commit_hash_length = 4;
         };

         git_branch = {
           truncation_length = 4;
           truncation_symbol = "";
           ignore_branches = ["master" "main"];
         };

        git_metrics = {
          added_style = "bold blue";
          format = "[+$added]($added_style)/[-$deleted]($deleted_style) ";
        };

        git_status = {
          conflicted = "[=/($count\)](${config.plusultra.color.Red})";
          ahead = "[⇡\($count\)](${config.plusultra.color.Magenta})";
          behind = "[⇣\($count\)](${config.plusultra.color.darkRed})";
          diverged = "[⇕\($count\)](${config.plusultra.color.darkWhite})";
          up_to_date = "[✓\($count\)](${config.plusultra.color.Blue})";
          untracked = "[?\($count\)](${config.plusultra.color.brightMagenta})";
          stashed = "[$\($count\)](${config.plusultra.color.Magenta})";
          modified = "[!\($count\)](${config.plusultra.color.Yellow})";
          staged = "[+\($count\)](${config.plusultra.color.Green})";
          renamed = "[»\($count\)](${config.plusultra.color.Orange})";
          deleted = "[✘\($count\)](${config.plusultra.color.brightRed})";
        };

        python = {
          symbol = "";
        };

        directory = {
          read_only = "";
          format = "[$path ](${config.plusultra.color.Blue})[$read_only](${config.plusultra.color.Red}) ";
          truncation_length = 16;
          truncation_symbol = "…/";
        };

        sudo = {
          format = "[](${config.plusultra.color.Orange})";
          disabled = false ;
        };

        cmd_duration = {
          min_time = 500;
          format = "[ $duration](${config.plusultra.color.Yellow})" ;
        };

        container = {
          format = "[ \\[$name\\]](${config.plusultra.color.Magenta})" ;
        };

        hostname = {
          format = "[$hostname](${config.plusultra.color.Magenta}) in ";
          disabled = false ;
        };

        memory_usage = {
          disabled = false;
          threshold = -1;
          format = "[ $ram](${config.plusultra.color.darkerGreen})";
        };

        status = {
          symbol = "";
          success_symbol = "";
          not_found_symbol = "";
          sigint_symbol = "";
          not_executable_symbol = "";
          format = "[\($symbol$common_meaning$signal_name$maybe_int\)](#101010)";
          map_symbol = true;
          disabled = false ;
        };
       };
    }; # }}}
  };
}
