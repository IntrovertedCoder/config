{ options, config, pkgs, lib, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.color;
in
{
  options.plusultra.color = with types; {
    # Without # {{{
      darkBlackNum      = mkOpt str "040404" "#040404";
      BlackNum          = mkOpt str "060606" "#060606";
      brightBlackNum    = mkOpt str "3B3B3B" "#3B3B3B";

      darkRedNum        = mkOpt str "9C000A" "#9C000A";
      RedNum            = mkOpt str "C7000C" "#C7000C";
      brightRedNum      = mkOpt str "FF0B1B" "#FF0B1B";

      darkerGreenNum    = mkOpt str "235A00" "#3C9C00";
      darkGreenNum      = mkOpt str "3C9C00" "#4CC700";
      GreenNum          = mkOpt str "4CC700" "#4CC700";
      brightGreenNum    = mkOpt str "68FF0B" "#68FF0B";

      darkYellowNum     = mkOpt str "AAA206" "#AAA206";
      YellowNum         = mkOpt str "D8C308" "#D8C308";
      brightYellowNum   = mkOpt str "F7ED26" "#F7ED26";

      darkBlueNum       = mkOpt str "0050D0" "#0050D0";
      BlueNum           = mkOpt str "0B68FF" "#0B68FF";
      brightBlueNum     = mkOpt str "3F88FF" "#3F88FF";

      darkMagentaNum    = mkOpt str "63457B" "#63457B";
      MagentaNum        = mkOpt str "7E599D" "#7E599D";
      brightMagentaNum  = mkOpt str "6A7AB4" "#6A7AB4";

      darkCyanNum       = mkOpt str "006DC0" "#006DC0";
      CyanNum           = mkOpt str "008CF7" "#008CF7";
      brightCyanNum     = mkOpt str "0BBAFF" "#0BBAFF";

      darkWhiteNum      = mkOpt str "949494" "#949494";
      WhiteNum          = mkOpt str "BCBCBC" "#BCBCBC";
      brightWhiteNum    = mkOpt str "EFEFEF" "#EFEFEF";

      darkOrangeNum     = mkOpt str "A55108" "#A55108";
      OrangeNum         = mkOpt str "D0670A" "#D0670A";
      brightOrangeNum   = mkOpt str "F58825" "#F58825";

      darkGrayNum       = mkOpt str "4C4C4C" "#4C4C4C";
      GrayNum           = mkOpt str "616161" "#616161";
      brightGrayNum     = mkOpt str "838383" "#838383";
    # }}}
    # With # {{{
      darkBlack = mkOpt str "#${cfg.darkBlackNum}" "darkBlack";
      Black = mkOpt str "#${cfg.BlackNum}" "Black";
      brightBlack = mkOpt str "#${cfg.brightBlackNum}" "brightBlack";

      darkRed = mkOpt str "#${cfg.darkRedNum}" "darkRed";
      Red = mkOpt str "#${cfg.RedNum}" "Red";
      brightRed = mkOpt str "#${cfg.brightRedNum}" "brightRed";

      darkerGreen = mkOpt str "#${cfg.darkerGreenNum}" "darkerGreen";
      darkGreen = mkOpt str "#${cfg.darkGreenNum}" "darkGreen";
      Green = mkOpt str "#${cfg.GreenNum}" "Green";
      brightGreen = mkOpt str "#${cfg.brightGreenNum}" "brightGreen";

      darkYellow = mkOpt str "#${cfg.darkYellowNum}" "darkYellow";
      Yellow = mkOpt str "#${cfg.YellowNum}" "Yellow";
      brightYellow = mkOpt str "#${cfg.brightYellowNum}" "brightYellow";

      darkBlue = mkOpt str "#${cfg.darkBlueNum}" "darkBlue";
      Blue = mkOpt str "#${cfg.BlueNum}" "Blue";
      brightBlue = mkOpt str "#${cfg.brightBlueNum}" "brightBlue";

      darkMagenta = mkOpt str "#${cfg.darkMagentaNum}" "darkMagenta";
      Magenta = mkOpt str "#${cfg.MagentaNum}" "Magenta";
      brightMagenta = mkOpt str "#${cfg.brightMagentaNum}" "brightMagenta";

      darkCyan = mkOpt str "#${cfg.darkCyanNum}" "darkCyan";
      Cyan = mkOpt str "#${cfg.CyanNum}" "Cyan";
      brightCyan = mkOpt str "#${cfg.brightCyanNum}" "brightCyan";

      darkWhite = mkOpt str "#${cfg.darkWhiteNum}" "darkWhite";
      White = mkOpt str "#${cfg.WhiteNum}" "White";
      brightWhite = mkOpt str "#${cfg.brightWhiteNum}" "brightWhite";

      darkOrange = mkOpt str "#${cfg.darkOrangeNum}" "darkOrange";
      Orange = mkOpt str "#${cfg.OrangeNum}" "Orange";
      brightOrange = mkOpt str "#${cfg.brightOrangeNum}" "brightOrange";

      darkGray = mkOpt str "#${cfg.darkGrayNum}" "darkGray";
      Gray = mkOpt str "#${cfg.GrayNum}" "Gray";
      brightGray = mkOpt str "#${cfg.brightGrayNum}" "brightGray";
    # }}}
  };
}
