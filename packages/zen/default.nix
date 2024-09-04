{ pkgs, lib, ... }:

let
  pname = "zen";
  version = "0.0.0-a.35";
  name = "${pname}-${version}";

  src = pkgs.fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/1.0.0-a.35/zen-specific.AppImage";
    sha256 = "975dd885be29453d6288443e237bdae3544aca5d7bf830c0b89120cf6b98e9f6";
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
    description = "Zen browser";
    homepage = "https://github.com/zen-browser/desktop/";
    license = licenses.gpl3;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
  };
}
