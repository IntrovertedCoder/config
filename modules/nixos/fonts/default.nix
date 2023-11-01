{ options, config, pkgs, lib, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.font;
in
{
  options.plusultra.font = with types; {
    Font = mkOpt str "Hack Regular Nerd Font Complete Mono" "Font";
  };
  config  = {
    environment.variables = {
      # Enable icons in tooling since we have nerdfonts
      LOG_ICONS = "true";
    };
    environment.systemPackages = with pkgs; [ font-manager ];
    fonts.fonts = with pkgs;
    [
      (nerdfonts.override { fonts = [ "Hack" ]; })
    ];
  };
}
