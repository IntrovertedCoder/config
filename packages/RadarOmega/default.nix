{ pkgs, lib, ... }:

let
  pname = "RadarOmega";
  version = "5.4.0";
  name = "${pname}-${version}";

  src = pkgs.fetchurl {
    url = "https://dl.todesktop.com/200402kk4yak2og/linux/appImage/x64";
    sha256 = "1a706e95e09a100574b283a890fe6e19bcdaaf332de38758bbaf9bc83ab17ea6";
  };

  appimageContents = pkgs.appimageTools.extractType2 { inherit name src; };
in
pkgs.appimageTools.wrapType2 rec {
  inherit name src;

  extraInstallCommands = ''
    mv $out/bin/${name} $out/bin/${pname}

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
