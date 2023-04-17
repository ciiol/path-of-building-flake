# Path Of Building Nix Flake

This repository provides a [Nix Flake](https://nixos.wiki/wiki/Flakes) for building and
running [PoBFrontend](https://github.com/ernstp/pobfrontend), a cross-platform driver
for [Path Of Building](https://github.com/PathOfBuildingCommunity/PathOfBuilding).

## Usage

In Nix environment with [enabled flakes](https://nixos.wiki/wiki/Flakes#Enable_flakes), you
can use the flake with the following command:

```sh
nix run github:ciiol/path-of-building-flake
```

## Contributions and fixes

This Flake has been tested only on macOS. Contributions and fixes for other platforms are welcome.
Feel free to open issues and submit pull requests.
