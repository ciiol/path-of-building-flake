{ pkgs }:

pkgs.rustPlatform.buildRustPackage (finalAttrs: {
  pname = "rusty-path-of-building";
  version = "0.3.4";

  src = pkgs.fetchFromGitHub {
    owner = "meehl";
    repo = "rusty-path-of-building";
    tag = "v${finalAttrs.version}";
    hash = "sha256-2FpiOX7JROAWbdPFwa1HaZxW+yMU8wM/Qu6ld3CDwHM=";
  };
  patches = [
    # Without this, PoB's user data would go to <script dir>/userdata, which is
    # in the read-only Nix store.
    ./patches/rpob-user-path.patch
  ];

  cargoHash = "sha256-HvKvkwZyd7MQ81Ru9rl67F8zL4kW6O8QoupLk1KjjKg=";

  nativeBuildInputs = [ pkgs.pkg-config ];

  buildInputs = [
    pkgs.aws-lc
    pkgs.curl
    pkgs.luajit
    pkgs.zstd
  ]
  ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.openssl ];

  # winit and wgpu dlopen these at runtime.
  postFixup = pkgs.lib.optionalString pkgs.stdenv.hostPlatform.isLinux ''
    patchelf $out/bin/rusty-path-of-building \
      --add-rpath ${
        pkgs.lib.makeLibraryPath [
          pkgs.libxkbcommon
          pkgs.vulkan-loader
          pkgs.wayland
          pkgs.libx11
          pkgs.libxcursor
          pkgs.libxi
        ]
      }
  '';

  meta.mainProgram = "rusty-path-of-building";
})
