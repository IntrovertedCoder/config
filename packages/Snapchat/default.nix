{ pkgs, lib, ... }:

let
  pname = "Snapchat";
  version = "1.0.4";
  name = "${pname}-${version}";

  src = pkgs.fetchurl {
    url = "https://gitlab.com/linuxbombay/snapchatdesktop/binaries/1.0.4/-/raw/main/Snapchat-x64.AppImage?ref_type=heads";
    sha256 = "8db8dca1bdb5077a5f014f480094d27c4ce351f2b914da882c4e126b64d1d104";
  };

  appimageContents = pkgs.appimageTools.extractType2 { inherit pname src version; };
in
pkgs.appimageTools.wrapType2 rec {
  inherit pname src version;

  extraInstallCommands = ''

      install -m 444 -D ${appimageContents}/snapchat.png $out/share/icons/hicolor/512x512/apps/${pname}.png

  '';

  meta = with lib; {
    description = "Snapchat desktop application";
    homepage = "https://gitlab.com/linuxbombay/snapchatdesktop/";
    license = licenses.gpl3;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
  };
}
