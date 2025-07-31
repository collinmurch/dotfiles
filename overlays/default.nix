externalFlakes: [
  (import ./nushell.nix)
  (import ./external-packages.nix externalFlakes)
  (import ./bitwarden-cli.nix)
]
