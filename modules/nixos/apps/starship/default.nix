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
           success_symbol = "[➜](${Green})";
           error_symbol = "[✗](${Red})";
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
          conflicted = "[=/($count\)](${Red})";
          ahead = "[⇡\($count\)](${Magenta})";
          behind = "[⇣\($count\)](${darkRed})";
          diverged = "[⇕\($count\)](${darkWhite})";
          up_to_date = "[✓\($count\)](${Blue})";
          untracked = "[?\($count\)](${brightMagenta})";
          stashed = "[$\($count\)](${Magenta})";
          modified = "[!\($count\)](${Yellow})";
          staged = "[+\($count\)](${Green})";
          renamed = "[»\($count\)](${Orange})";
          deleted = "[✘\($count\)](${brightRed})";
        };

        python = {
          symbol = "";
        };

        directory = {
          read_only = "";
          format = "[$path ](${Blue})[$read_only](${Red}) ";
          truncation_length = 16;
          truncation_symbol = "…/";
        };

        sudo = {
          format = "[](${Orange})";
          disabled = false ;
        };

        cmd_duration = {
          min_time = 500;
          format = "[ $duration](${Yellow})" ;
        };

        container = {
          format = "[ \\[$name\\]](${Magenta})" ;
        };

        hostname = {
          format = "[$hostname](${Magenta}) in ";
          disabled = false ;
        };

        memory_usage = {
          disabled = false;
          threshold = -1;
          format = "[ $ram](${darkerGreen})";
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
