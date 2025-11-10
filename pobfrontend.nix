{ pkgs, luaEnv }:

pkgs.stdenv.mkDerivation rec {
  pname = "pobfrontend";
  version = "latest";

  src = pkgs.fetchFromGitHub {
    owner = "ernstp";
    repo = "pobfrontend";
    rev = "7e09fdc29d1e72e9122db71e41ba03fd54bf428b";
    sha256 = "1dzwb8sq3341myk6djqcyxy5yly9g3dh8jn1fkyy37pkgkrwzbwi";
  };

  buildInputs = with pkgs; [
    meson
    ninja
    pkg-config
    qt6.qtbase
    zlib
    luaEnv
  ];

  nativeBuildInputs = [
    pkgs.qt6.wrapQtAppsHook
  ];

  env.NIX_CFLAGS_COMPILE = pkgs.lib.optionalString pkgs.stdenv.hostPlatform.isDarwin "-F${pkgs.qt6.qtbase}/lib";

  installPhase = ''
    install -D -m755 pobfrontend $out/pobfrontend
  '';
}
