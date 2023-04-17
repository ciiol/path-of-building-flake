{ pkgs, luaEnv }:

pkgs.stdenv.mkDerivation rec {
  pname = "path-of-building";
  version = "2.28.0";
  name = "path-of-building-${version}";

  src = fetchTarball {
    url = "https://github.com/PathOfBuildingCommunity/PathOfBuilding/archive/refs/tags/v${version}.tar.gz";
    sha256 = "14y2h2mp9ppifaxikb3a6vff424pa31cvkaqdri36wlf9r8amvi0";
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
