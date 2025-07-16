{ pkgs, luaEnv }:

pkgs.stdenv.mkDerivation rec {
  pname = "pobfrontend";
  version = "latest";

  src = pkgs.fetchFromGitHub {
    owner = "ernstp";
    repo = "pobfrontend";
    rev = "c8bb91fdbd1648f448052b2b8942e4f9c4df8875";
    sha256 = "1r643arglx0wzszjlgw0mcdx3k6a0lfdsdhfi9xiy9lmp12h99yi";
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
