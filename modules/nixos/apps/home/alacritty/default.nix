{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.alacritty;
in
{
  options.plusultra.apps.home.alacritty = with types; {
    enable = mkBoolOpt false "Whether or not to enable alacritty.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions.programs.alacritty = {
      enable = true;
      settings = {
        colors = {
          # Default colors
          primary = {
            background = config.plusultra.color.Black;
            foreground = config.plusultra.color.White;
          };
          # Normal colors
          normal = {
            black =   config.plusultra.color.Black;
            red =     config.plusultra.color.Red;
            green =   config.plusultra.color.Green;
            yellow =  config.plusultra.color.Yellow;
            blue =    config.plusultra.color.Blue;
            magenta = config.plusultra.color.Magenta;
            cyan =    config.plusultra.color.Cyan;
            white =   config.plusultra.color.White;
          };
          # Bright colors
          bright = {
            black =   config.plusultra.color.brightBlack;
            red =     config.plusultra.color.brightRed;
            green =   config.plusultra.color.brightGreen;
            yellow =  config.plusultra.color.brightYellow;
            blue =    config.plusultra.color.brightBlue;
            magenta = config.plusultra.color.brightMagenta;
            cyan =    config.plusultra.color.brightCyan;
            white =   config.plusultra.color.brightWhite;
          };
          dim = {
            black =   config.plusultra.color.darkBlack;
            red =     config.plusultra.color.darkRed;
            green =   config.plusultra.color.darkGreen;
            yellow =  config.plusultra.color.darkYellow;
            blue =    config.plusultra.color.darkBlue;
            magenta = config.plusultra.color.darkMagenta;
            cyan =    config.plusultra.color.darkCyan;
            white =   config.plusultra.color.darkWhite;
          };
        };

        fonts = {
          normal = {
            family = "${config.plusultra.font.Font}";
            style =  "Regular";
          };
        };
      };
    };
  };
}
