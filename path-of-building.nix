{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "path-of-building";
  version = "2.68.1";
  name = "path-of-building-${version}";
  outputs = [
    "out"
    "env"
  ];

  src = fetchTarball {
    url = "https://github.com/PathOfBuildingCommunity/PathOfBuilding/archive/refs/tags/v${version}.tar.gz";
    sha256 = "143b4yfx7bk8wm2hmfczwfv4sj03v058aykdxpd6idrxz9a5mln1";
  };
  patches = [ ./patches/pob-stop-updates.patch ];

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
    export LUA_PATH='$out/runtime/lua/?.lua;$out/runtime/lua/?/init.lua;$out/src/?.lua'
    export LUA_CPATH=
    EOL
  '';
}
