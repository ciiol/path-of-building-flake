{ pkgs, luaEnv }:

pkgs.stdenv.mkDerivation rec {
  pname = "path-of-building";
  version = "2.31.2";
  name = "path-of-building-${version}";

  src = fetchTarball {
    url = "https://github.com/PathOfBuildingCommunity/PathOfBuilding/archive/refs/tags/v${version}.tar.gz";
    sha256 = "1kxmynj8by4hwvvflasrqp9ipwy1l4gywk2rhwy1vy2hhnwzqphk";
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
