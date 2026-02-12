{
  description = "Path Of Building - Offline build planner for Path of Exile.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        luacurl = (import ./lua-curl-v3.nix) {
          pkgs = pkgs;
          luaPackages = pkgs.luajitPackages;
        };
        luaEnv = pkgs.luajitPackages.lua.withPackages (
          ps: with ps; [
            luacurl
            luautf8
          ]
        );
        launcher =
          packages:
          pkgs.writeShellScript "launcher" ''
            set -e
            cd ${packages.path-of-building.out}
            source ${packages.path-of-building.env}
            exec ${packages.pobfrontend.out}/pobfrontend $@
          '';
      in
      rec {
        packages = {
          pobfrontend = (import ./pobfrontend.nix) { inherit pkgs luaEnv; };
          path-of-building = (import ./path-of-building.nix) { inherit pkgs luaEnv; };
        };

        apps = {
          default = {
            type = "app";
            program = "${launcher packages}";
          };
          pobfrontend = {
            type = "app";
            program = "${packages.pobfrontend.out}/pobfrontend";
          };
        };

        defaultPackage = packages.path-of-building;
      }
    );
}
