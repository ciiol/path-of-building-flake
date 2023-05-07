{ pkgs, luaEnv }:

pkgs.stdenv.mkDerivation rec {
  pname = "path-of-building";
  version = "2.30.1";
  name = "path-of-building-${version}";

  src = fetchTarball {
    url = "https://github.com/PathOfBuildingCommunity/PathOfBuilding/archive/refs/tags/v${version}.tar.gz";
    sha256 = "17ilil7nw2xnwjp6vi8irqn0hcrwkqczwnr9czjf1w95p005qays";
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
