self: super:
{
  nushell = super.nushell.overrideAttrs (oldAttrs: {
    cargoPatches = (oldAttrs.cargoPatches or []) ++ [
      (super.writeText "reedline-fork.patch" ''
        --- a/Cargo.toml
        +++ b/Cargo.toml
        @@ -280,0 +280,3 @@ nu-ansi-term = {git = "https://github.com/nushell/nu-ansi-term.git", branch = "
         # Run all benchmarks with `cargo bench`
         # Run individual benchmarks like `cargo bench -- <regex>` e.g. `cargo bench -- parse`
         [[bench]]
        +
        +[patch."https://github.com/nushell/reedline"]
        +reedline = { git = "https://github.com/collinmurch/reedline", branch = "main" }
      '')
    ];
  });
}
