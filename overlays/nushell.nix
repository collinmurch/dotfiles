final: prev:
let
  rustPackages = prev.rustPackages_1_88; # Nushell 0.107.1 needs rustc >= 1.88
in {
  # Temporary use my fork until nushell merges the reedline fix
  nushell = rustPackages.rustPlatform.buildRustPackage {
    pname = "nushell";
    version = "0.107.1";

    src = prev.fetchFromGitHub {
      owner = "collinmurch";
      repo = "nushell";
      rev = "main";
      hash = "sha256-mWpy2mb8CEFySzSiiWFIRSw2zSaLPpIswj3zlJ0Q+bA=";
    };

    cargoHash = "sha256-Y02KmdZk6u/UVA+/SwcYr56ugU5liqnVdQk6mLB/lck=";

    nativeBuildInputs = with prev; [ pkg-config ];

    cargoBuildFlags = [ "--features=default" ];
    doCheck = false;
  };
}
