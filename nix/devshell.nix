{
  perSystem = {
    self',
    pkgs,
    env,
    meta,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      inherit env;

      # We use rustup instead to make use of the existing make infrastructure in Namada.
      packages = meta.allBuildInputs ++ [pkgs.rustup];
    };
  };
}
