{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.thunar;
in
{
  options.plusultra.apps.home.thunar = with types; {
    enable = mkBoolOpt false "Whether or not to enable thunar.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [
    plusultra.home.extraOptions = {
      gtk = {
        enable = true;
        # iconTheme = {
          # package = pkgs.gnome.adwaita-icon-theme;
          # name = "Adwaita";
        # };
        theme = {
          package = pkgs.gnome.adwaita-icon-theme;
          name = "Adwaita";
        };
        gtk3.bookmarks = [
          "file:///home/arik/Documents"
          "file:///home/arik/Downloads"
        ];
      };
    };
    plusultra.home.extraOptions.home.packages = with pkgs; [
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.thunar-media-tags-plugin
      xfce.thunar-volman
      xfce.tumbler
    ];
    services.gvfs.enable = true;
  };
}
