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
        rpob = packages: pkgs.lib.getExe packages.rusty-path-of-building;
        # rusty-path-of-building runs the PoB found in the current directory
        # and skips its own download of PoB.
        launcher =
          packages:
          pkgs.writeShellScript "launcher" ''
            set -e
            cd ${packages.path-of-building.out}
            source ${packages.path-of-building.env}
            exec ${rpob packages} poe1 "$@"
          '';
      in
      rec {
        packages = {
          rusty-path-of-building = (import ./rusty-path-of-building.nix) { inherit pkgs; };
          path-of-building = (import ./path-of-building.nix) { inherit pkgs; };
        };

        apps = {
          default = {
            type = "app";
            program = "${launcher packages}";
          };
          rusty-path-of-building = {
            type = "app";
            program = rpob packages;
          };
        };

        defaultPackage = packages.path-of-building;
      }
    );
}
