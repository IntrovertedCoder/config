{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.addons.mako;
in
{
  options.plusultra.desktop.addons.mako = with types; {
    enable = mkBoolOpt false "Whether or not to enable mako.";
  };

  config = mkIf cfg.enable {
    plusultra.desktop.Hyprland.extraConfig = mkIf config.plusultra.desktop.Hyprland.enable ''
      ## Notification control
      bind = $mainMod, n, exec, makoctl restore
      bind = $mainMod, m, exec, makoctl dismiss
      bind = $mainMod SHIFT, n, exec, makoctl dismiss -a
    '';
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
