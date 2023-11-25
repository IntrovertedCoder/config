{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.git;
in
{
  options.plusultra.apps.home.git = with types; {
    enable = mkBoolOpt false "Whether or not to enable git.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ git ];
    # plusultra.home.extraOptions.home.packages = with pkgs; [ git ];
    plusultra.home.extraOptions = {
      programs.git = {
        enable = true;
        delta.enable = true;
        userEmail = config.plusultra.user.email;
        userName = "IntrovertedCoder";
      };
    };
  };
}
