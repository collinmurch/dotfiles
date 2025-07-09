self: super:
let
  src = super.fetchFromGitHub {
    owner = "collinmurch";
    repo  = "nushell";
    rev   = "de49eb16f0fcf8370d8ee4aa240580121bbe9e4d";
    hash  = "sha256-r9Pfow10HW6HsADirIJTXOPZPNOFMM43dh4YlXhzBq0=";
  };
in
{
  nushell = super.rustPlatform.buildRustPackage {
    pname   = "nushell";
    version = "0.0.1";
    inherit src;
    cargoHash = "sha256-8W9wO3VQlLJD1G64kH5kO0HIEIt7JjSpNr3ksJq9eWA=";
    cargoBuildFlags = [
      "--no-default-features"
      "--features=rustls-tls"
    ];
    nativeBuildInputs = with super; [ pkg-config cmake ];
    buildInputs       = [ ];
    doCheck           = false;
  };
}
