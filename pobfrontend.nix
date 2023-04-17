{ pkgs, luaEnv }:

pkgs.stdenv.mkDerivation rec {
  pname = "pobfrontend";
  version = "latest";

  src = pkgs.fetchFromGitHub {
    owner = "ernstp";
    repo = "pobfrontend";
    rev = "9faa19aa362f975737169824c1578d5011487c18";
    sha256 = "0sgdylky5bg4v5f7610vp61iw6b03jh6pghiv8cwhd4rkqykc76f";
  };

  buildInputs = with pkgs; [
    meson
    ninja
    pkg-config
    qt6.wrapQtAppsHook
  ];

  nativeBuildInputs = [
    pkgs.qt6.qtbase
    pkgs.zlib
    luaEnv
  ];

  installPhase = ''
    install -D -m755 pobfrontend $out/pobfrontend
  '';
}
