{ pkgs, luaEnv }:

pkgs.stdenv.mkDerivation rec {
  pname = "path-of-building";
  version = "2.33.2";
  name = "path-of-building-${version}";
  outputs = [ "out" "env" ];

  src = fetchTarball {
    url = "https://github.com/PathOfBuildingCommunity/PathOfBuilding/archive/refs/tags/v${version}.tar.gz";
    sha256 = "0sxv6xvkk9jz4q7sjsch8bqdb43mza7gvvma0w3bgjrr32cnjm7s";
  };
  patches = [ ./patches/pob-stop-updates.patch ];

  nativeBuildInputs = [
    luaEnv
  ];

  installPhase = ''
    mkdir -p $out/runtime
    cp -r runtime/lua/ $out/runtime/lua
    cp -r spec/ $out/spec
    cp -r src/ $out/src

    cp changelog.txt help.txt $out/src
    touch $out/installed.cfg

    cat >$out/manifest.xml <<EOL
    <?xml version='1.0' encoding='UTF-8'?>
    <PoBVersion>
      <Version number="${version}" branch="release" platform="nix"/>
    </PoBVersion>
    EOL

    cat >$env <<EOL
    export LUA_PATH='$out/runtime/lua/?.lua;$out/runtime/lua/?/init.lua'
    export LUA_CPATH='${luaEnv}/lib/lua/${luaEnv.lua.luaversion}/?.so'
    EOL
  '';
}
