{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.mako;
in
{
  options.plusultra.apps.home.mako = with types; {
    enable = mkBoolOpt false "Whether or not to enable mako.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions.services = {
      mako = { # {{{
        enable = true;
        anchor = "top-right";
        backgroundColor = config.plusultra.color.Black;
        borderColor = config.plusultra.color.Blue;
        borderRadius = 1;
        borderSize = 2;
        defaultTimeout = 5000;
        font = config.plusultra.font.Font;
        textColor = config.plusultra.color.White;
      }; # }}}
    };
  };
}