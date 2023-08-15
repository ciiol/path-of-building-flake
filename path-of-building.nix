{ pkgs, luaEnv }:

pkgs.stdenv.mkDerivation rec {
  pname = "path-of-building";
  version = "2.31.1";
  name = "path-of-building-${version}";

  src = fetchTarball {
    url = "https://github.com/PathOfBuildingCommunity/PathOfBuilding/archive/refs/tags/v${version}.tar.gz";
    sha256 = "0m55j6mbxrm6bd76x7y5ab1jcg271i32xzv3h3blzq9ghlsvryrb";
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
