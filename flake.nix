{
  description = "Collin's dot-files & package bundle (Nix flakes + Stow)";

  inputs = {
    nixpkgs.url     = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    helix.url       = "github:helix-editor/helix/master";
    helix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url      = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nixpkgs, nixpkgs-unstable, flake-utils, helix, agenix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        externalFlakes = { inherit helix agenix; };
        pkgs = import nixpkgs {
          inherit system;
          overlays = import ./overlays externalFlakes;
          config = {
            allowUnfree  = true;
            allowBroken  = true;
          };
        };
        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config = {
            allowUnfree  = true;
            allowBroken  = true;
          };
        };
        wanted  = import ./pkg-set.nix { inherit pkgs pkgs-unstable; } ++ [ agenix.packages.${system}.default ];

        pkg-set = pkgs.buildEnv {
          name  = "collin-packages";
          paths = wanted;
        };
        bootstrap = pkgs.writeShellApplication {
          name          = "collin-bootstrap";
          runtimeInputs = [ pkgs.git pkgs.stow pkgs.bat ];
          meta = {
            description = "Bootstrap dotfiles and configure system";
            mainProgram = "collin-bootstrap";
          };
          text = builtins.readFile ./bootstrap.sh;
        };
      in {
        packages.pkg-set = pkg-set; # nix profile install .#pkg-set
        apps.bootstrap   = {
          type = "app";
          program = "${bootstrap}/bin/collin-bootstrap";
          meta = {
            description = "Bootstrap dotfiles and configure system";
            mainProgram = "collin-bootstrap";
          };
        };  # nix run .#bootstrap
      });
}
