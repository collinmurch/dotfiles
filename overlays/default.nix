externalFlakes: [
  (import ./nushell.nix)
  (import ./external-packages.nix externalFlakes)
]
