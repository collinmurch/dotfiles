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
      hash = "sha256-4N0PrMmlbQxFUlpOpTjmI/28bNAy8Y/OewOEf5IIcZc=";
    };

    cargoHash = "sha256-yFWUcuaz+kY+kaOy3xub1riQjDiSPykgmjlTdBJGGD4=";

    nativeBuildInputs = with prev; [ pkg-config ];

    cargoBuildFlags = [ "--features=default" ];
    doCheck = false;
  };
}
