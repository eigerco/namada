{
  perSystem = {
    self',
    pkgs,
    ...
  }: {
    _module.args.meta = rec {
      src = ../.;

      cargoToml = ../Cargo.toml;
      lockFile = ../Cargo.lock;

      cargoManifest = builtins.fromTOML (builtins.readFile cargoToml);

      rustToolchain = pkgs.rust-bin.fromRustupToolchainFile ../rust-toolchain.toml;

      nativeBuildInputs = with pkgs; [
        self'.packages.cometbft

        binaryen # wasm-opt.
        blst
        clang.cc # Needed for compiling WASM txs.
        gnumake
        pkg-config
        protobuf
        (python3.withPackages (python-pkgs:
          with python-pkgs; [
            toml
          ]))
      ];

      buildInputs = with pkgs; [
        openssl
        rocksdb
        systemd # libudev.
      ];

      allBuildInputs = nativeBuildInputs ++ buildInputs;
    };
  };
}
