{ pkgs, lib, ... }:

let
  pname = "zen";
  version = "0.0.0-a.35";
  name = "${pname}-${version}";

  src = pkgs.fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/1.12.8b/zen-x86_64.AppImage";
    sha256 = "f7be27f1b7899c94c2802edafe3c3203b303ba1918d8589d5f48a2993a885488";
  };

  appimageContents = pkgs.appimageTools.extractType2 { inherit pname version src; };
in
pkgs.appimageTools.wrapType2 rec {
  inherit pname version src;

  extraInstallCommands = ''

    install -m 444 -D ${appimageContents}/${pname}.png $out/share/icons/hicolor/512x512/apps/${pname}.png

  '';

  meta = with lib; {
    description = "Zen browser";
    homepage = "https://github.com/zen-browser/desktop/";
    license = licenses.gpl3;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
  };
}
