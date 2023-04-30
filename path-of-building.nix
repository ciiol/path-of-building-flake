{ pkgs, luaEnv }:

pkgs.stdenv.mkDerivation rec {
  pname = "path-of-building";
  version = "2.29.0";
  name = "path-of-building-${version}";

  src = fetchTarball {
    url = "https://github.com/PathOfBuildingCommunity/PathOfBuilding/archive/refs/tags/v${version}.tar.gz";
    sha256 = "0xa1lw95v2cpgh40yl7lxymsklka4xldkw5ffxr6x81ykmpr0vxq";
  };

  nativeBuildInputs = [
    luaEnv
  ];

  installPhase = ''
    mkdir -p $out/runtime
    cp -r $src/runtime/lua/ $out/runtime/lua
    cp -r $src/spec/ $out/spec
    cp -r $src/src/ $out/src
    ln -s ${luaEnv}/lib/lua/${luaEnv.lua.luaversion}/lcurl.so $out/lcurl.so
  '';
}
