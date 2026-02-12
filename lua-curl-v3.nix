{ pkgs, luaPackages }:

luaPackages.toLuaModule (
  pkgs.stdenv.mkDerivation rec {
    pname = "luacurl";
    version = "0.3.13";
    name = "luacurl-${version}";

    src = fetchTarball {
      url = "https://github.com/Lua-cURL/Lua-cURLv3/archive/refs/tags/v${version}.tar.gz";
      sha256 = "0gn59bwrnb2mvl8i0ycr6m3jmlgx86xlr9mwnc85zfhj7zhi5anp";
    };

    buildInputs = [
      pkgs.pkg-config
    ];

    nativeBuildInputs = [
      luaPackages.lua
      pkgs.curl
    ];

    buildPhase = ''
      export LUA_LMOD="$out/share/lua/${luaPackages.lua.luaversion}"
      export LUA_CMOD="$out/lib/lua/${luaPackages.lua.luaversion}"
      make all
    '';

    installPhase = ''
      export LUA_LMOD="$out/share/lua/${luaPackages.lua.luaversion}"
      export LUA_CMOD="$out/lib/lua/${luaPackages.lua.luaversion}"
      make install
    '';

  }
)
