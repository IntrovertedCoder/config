{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.ncmpcpp;
in
{
  options.plusultra.apps.home.ncmpcpp = with types; {
    enable = mkBoolOpt false "Whether or not to enable ncmpcpp.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions.programs = {
      ncmpcpp = {
        enable = true;
        package = pkgs.ncmpcpp.override { visualizerSupport = true; };
        settings = {
          external_editor = "vim";
        };
        bindings = [
          { key = "j"; command = "scroll_down"; }
          { key = "k"; command = "scroll_up"; }
          { key = "J"; command = [ "select_item" "scroll_down" ]; }
          { key = "K"; command = [ "select_item" "scroll_up" ]; }
        ];
      };
    };
  };
}
