{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.foot;
in
{
  options.plusultra.apps.home.foot = with types; {
    enable = mkBoolOpt false "Whether or not to enable foot.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions.programs.foot = {
      enable = true;
      settings = {
        main = {
          # font = "${config.plusultra.font.Font}:size=9";
          dpi-aware = "yes";
        };
        colors = {
          background = config.plusultra.color.BlackNum;
          foreground = config.plusultra.color.WhiteNum;


          regular0 = config.plusultra.color.BlackNum;
          regular1 = config.plusultra.color.RedNum;
          regular2 = config.plusultra.color.GreenNum;
          regular3 = config.plusultra.color.YellowNum;
          regular4 = config.plusultra.color.BlueNum;
          regular5 = config.plusultra.color.MagentaNum;
          regular6 = config.plusultra.color.CyanNum;
          regular7 = config.plusultra.color.WhiteNum;


          bright0 = config.plusultra.color.brightBlackNum;
          bright1 = config.plusultra.color.brightRedNum;
          bright2 = config.plusultra.color.brightGreenNum;
          bright3 = config.plusultra.color.brightYellowNum;
          bright4 = config.plusultra.color.brightBlueNum;
          bright5 = config.plusultra.color.brightMagentaNum;
          bright6 = config.plusultra.color.brightCyanNum;
          bright7 = config.plusultra.color.brightWhiteNum;


          dim0 = config.plusultra.color.darkBlackNum;
          dim1 = config.plusultra.color.darkRedNum;
          dim2 = config.plusultra.color.darkGreenNum;
          dim3 = config.plusultra.color.darkYellowNum;
          dim4 = config.plusultra.color.darkBlueNum;
          dim5 = config.plusultra.color.darkMagentaNum;
          dim6 = config.plusultra.color.darkCyanNum;
          dim7 = config.plusultra.color.darkWhiteNum;
        };
      };
    };
  };
}
