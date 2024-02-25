{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.zathura;
in
{
  options.plusultra.apps.home.zathura = with types; {
    enable = mkBoolOpt false "Whether or not to enable zathura.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions.programs.zathura = {
      enable = true;
      options = {
        default-bg = config.plusultra.color.Black;
        default-fg = config.plusultra.color.White;
        completion-highlight-fg = config.plusultra.color.brightBlack;
        completion-highlight-bg = config.plusultra.color.Blue;
        completion-group-fg = config.plusultra.color.darkWhite;
        completion-group-bg = config.plusultra.color.Black;
        completion-bg = config.plusultra.color.brightBlack;
        completion-fg = config.plusultra.color.Gray;
        font = config.plusultra.font.Font;

        selection-clipboard = "clipboard";
      };
    };
    plusultra.home.defaultApplications = {
      "application/postcript" = [ "Zathura.desktop" ];
      "application/x+fictionbook+xml" = [ "Zathura.desktop" ];
      "application/epub+zip" = [ "Zathura.desktop" ];
      "application/pdf" = [ "Zathura.desktop" ];
      "application/x-tar" = [ "Zathura.desktop" ];
    };
  };
}
