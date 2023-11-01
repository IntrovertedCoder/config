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
  config.environment.systemPackages = with pkgs;
  [
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];
}
