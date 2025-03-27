{ pkgs, lib, ... }:

let
  pname = "Snapchat";
  version = "1.0.2-2";
  name = "${pname}-${version}";

  src = pkgs.fetchurl {
    url = "https://gitlab.com/linuxbombay/snapchatdesktop/binaries/1.0.2-2/-/raw/main/Snapchat-x64.AppImage?ref_type=heads";
    sha256 = "285dae3f7c4235f420b9ec9090aea36aee059ccb4fe5612cc70933c1d988fb6d";
  };

  appimageContents = pkgs.appimageTools.extractType2 { inherit name src; };
in
pkgs.appimageTools.wrapType2 rec {
  inherit name src;

  extraInstallCommands = ''
    mv $out/bin/${name} $out/bin/${pname}

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
