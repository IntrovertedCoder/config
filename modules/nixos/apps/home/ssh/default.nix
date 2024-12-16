{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.ssh;
in
{
  options.plusultra.apps.home.ssh = with types; {
    enable = mkBoolOpt false "Whether or not to enable .ssh/config.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ ssh ];
    # plusultra.home.extraOptions.home.packages = with pkgs; [ ssh ];
    plusultra.home.file.".ssh/config".text = ''
      Host github.com
        HostName github.com
        IdentityFile ~/.ssh/github
      Host iridium
        HostName 192.168.0.77
        IdentityFile ~/.ssh/nixos
      Host iridiumwifi
        HostName 192.168.0.75
        IdentityFile ~/.ssh/nixos
      Host Iridium
        HostName 192.168.2.77
        IdentityFile ~/.ssh/nixos
      Host WGHost
        HostName 172.17.0.1
        IdentityFile ~/.ssh/nixos
    '';
  };
}
