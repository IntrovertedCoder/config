{ pkgs, lib, ... }:

let
  pname = "RadarOmega";
  version = "5.5.0";
  name = "${pname}-${version}";

  src = pkgs.fetchurl {
    url = "https://dl.todesktop.com/200402kk4yak2og/linux/appImage/x64";
    sha256 = "c8f3b2bbb56ed37d1c2fb815b4d851e0083e073d07f038942571a615f828b845";
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
