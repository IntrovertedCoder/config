{ pkgs, lib, ... }:

let
  pname = "RadarOmega";
  version = "5.5.0";
  name = "${pname}-${version}";

  src = pkgs.fetchurl {
    url = "https://dl.todesktop.com/200402kk4yak2og/linux/appImage/x64";
    sha256 = "c34e05f4a1b37e631a64f6f79ae0595fa56269e4861d39ba754dbb9bd7a2fc42";
  };

  appimageContents = pkgs.appimageTools.extractType2 { inherit pname version src; };
in
pkgs.appimageTools.wrapType2 rec {
  inherit pname version src;

  extraInstallCommands = ''

    install -m 444 -D ${appimageContents}/${pname}.png $out/share/icons/hicolor/512x512/apps/${pname}.png

  '';

  meta = with lib; {
    description = "RadarOmega storm tracking app";
    homepage = "https://www.radaromega.com/";
    license = licenses.gpl3;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
  };
}
