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
      hash = "sha256-nECTW1DTJ1HVF2kCV+kAiaH0lVFhcCpuWJPZSAVYjLM=";
    };

    cargoHash = "sha256-ta1F2zpvBwGw9l9Ei/a3HTqH4dlYUeb0trKT+C2HjaY=";

    nativeBuildInputs = with prev; [ pkg-config ];

    cargoBuildFlags = [ "--features=default" ];
    doCheck = false;
  };
}
