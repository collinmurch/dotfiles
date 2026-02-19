{
  description = "Collin's dot-files & package bundle (Nix flakes + Stow)";

  inputs = {
    nixpkgs.url     = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    agenix.url      = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nixpkgs, nixpkgs-unstable, flake-utils, agenix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree  = true;
          };
        };
        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config = {
            allowUnfree  = true;
          };
        };
        wanted  = import ./pkg-set.nix { inherit pkgs pkgs-unstable; } ++ [ agenix.packages.${system}.default ];

        pkg-set = pkgs.buildEnv {
          name  = "collin-packages";
          paths = wanted;
        };
        bootstrap = pkgs.writeShellApplication {
          name          = "collin-bootstrap";
          runtimeInputs = [
            pkgs.git
            pkgs.stow
            pkgs.bat
            pkgs-unstable.nushell
            pkgs.bitwarden-cli
            pkgs.age
            pkgs.ssh-to-age
          ];
          meta = {
            description = "Bootstrap dotfiles and configure system";
            mainProgram = "collin-bootstrap";
          };
          text = builtins.readFile ./bootstrap.sh;
        };
      in {
        packages.pkg-set   = pkg-set; # nix profile install .#pkg-set
        packages.bootstrap = bootstrap; # nix build .#bootstrap
        apps.bootstrap   = {
          type = "app";
          program = "${bootstrap}/bin/collin-bootstrap";
        };  # nix run .#bootstrap
      });
}
