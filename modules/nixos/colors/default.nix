{ options, config, pkgs, lib, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.color;
in
{
  options.plusultra.color = with types; {
    darkBlack = mkOpt str "#040404" "darkBlack";
    Black = mkOpt str "#060606" "Black";
    brightBlack = mkOpt str "#3B3B3B" "brightBlack";

    darkRed = mkOpt str "#9C000A" "darkRed";
    Red = mkOpt str "#C7000C" "Red";
    brightRed = mkOpt str "#FF0B1B" "brightRed";

    darkerGreen = mkOpt str "#235A00" "darkerGreen";
    darkGreen = mkOpt str "#3C9C00" "darkGreen";
    Green = mkOpt str "#4CC700" "Green";
    brightGreen = mkOpt str "#68FF0B" "brightGreen";

    darkYellow = mkOpt str "#AAA206" "darkYellow";
    Yellow = mkOpt str "#D8C308" "Yellow";
    brightYellow = mkOpt str "#F7ED26" "brightYellow";

    darkBlue = mkOpt str "#0050D0" "darkBlue";
    Blue = mkOpt str "#0B68FF" "Blue";
    brightBlue = mkOpt str "#3F88FF" "brightBlue";

    darkMagenta = mkOpt str "#63457B" "darkMagenta";
    Magenta = mkOpt str "#7E599D" "Magenta";
    brightMagenta = mkOpt str "#6A7AB4" "brightMagenta";

    darkCyan = mkOpt str "#006DC0" "darkCyan";
    Cyan = mkOpt str "#008CF7" "Cyan";
    brightCyan = mkOpt str "#0BBAFF" "brightCyan";

    darkWhite = mkOpt str "#949494" "darkWhite";
    White = mkOpt str "#BCBCBC" "White";
    brightWhite = mkOpt str "#EFEFEF" "brightWhite";

    darkOrange = mkOpt str "#A55108" "darkOrange";
    Orange = mkOpt str "#D0670A" "Orange";
    brightOrange = mkOpt str "#F58825" "brightOrange";

    darkGray = mkOpt str "#4C4C4C" "darkGray";
    Gray = mkOpt str "#616161" "Gray";
    brightGray = mkOpt str "#838383" "brightGray";

    Font = mkOpt str "Hack Regular Nerd Font Complete Mono" "Font";
  };
}
