self: super:
let
  src = super.fetchFromGitHub {
    owner = "collinmurch";
    repo  = "nushell";
    rev   = "853ee847a82e3c1ea975486fe923beb48a2d4887";
    hash  = "sha256-MTBOPCxn0GWwixMNhb9MvfJrBSkEMGXPVMcFbGb6AM8=";
  };
in
{
  nushell = super.rustPlatform.buildRustPackage {
    pname   = "nushell";
    version = "0.0.1";
    inherit src;
    cargoHash = "sha256-firVJQA9jDgve9BMSN7VEovvhrrUNPUuVlte3Xdh3JQ=";
    cargoBuildFlags = [
      "--no-default-features"
      "--features=rustls-tls"
    ];
    nativeBuildInputs = with super; [ pkg-config cmake ];
    buildInputs       = [ ];
    doCheck           = false;
  };
}
