{
  description = "Collin's dot-files & package bundle (Nix flakes + Stow)";

  inputs = {
    nixpkgs.url     = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    helix.url       = "github:helix-editor/helix/master";
    helix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nixpkgs, flake-utils, helix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        externalFlakes = { inherit helix; };
        pkgs = import nixpkgs {
          inherit system;
          overlays = import ./overlays externalFlakes;
          config = {
            allowUnfree  = true;
            allowBroken  = true;
          };
        };
        wanted  = import ./pkg-set.nix { inherit pkgs; };

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
