{
  perSystem = {
    self',
    pkgs,
    env,
    meta,
    ...
  }: {
    packages.default = pkgs.rustPlatform.buildRustPackage {
      inherit env;
      inherit (meta) src buildInputs;
      inherit (meta.cargoManifest.workspace.package) version;

      pname = "namada";

      cargoLock = {
        inherit (meta) lockFile;
      };

      nativeBuildInputs = meta.nativeBuildInputs ++ [meta.rustToolchain];

      # Disable the check phase to speed up build times.
      doCheck = false;
    };
  };
}
