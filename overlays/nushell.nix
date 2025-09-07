self: super:
{
  # Temporary use my fork until nushell merges the reedline fix
  nushell = super.rustPlatform.buildRustPackage {
    pname = "nushell";
    version = "0.106.2";

    src = super.fetchFromGitHub {
      owner = "collinmurch";
      repo = "nushell";
      rev = "main";
      hash = "sha256-Myj5sAPQJk7HvmtDx52G9iz354IXA95YqfJ/ccaFvSk=";
    };

    cargoHash = "sha256-id3Y463zOzKLmmV6Ww4YVA2LIz2hJ7JzHGkAm98HyAE=";

    nativeBuildInputs = with super; [ pkg-config ];

    cargoBuildFlags = [ "--features=default" ];
    doCheck = false;
  };
}
