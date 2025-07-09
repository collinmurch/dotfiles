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
        wanted  = import ./pkg-list.nix { inherit pkgs system; };

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
          text = ''
#!/usr/bin/env bash
set -euo pipefail

echo " Cloning git repository..."
git clone --recurse-submodules https://github.com/collinmurch/dotfiles ~

echo "→ Linking dot-files with stow…"
stow --no-folding -d ~/dotfiles -t ~ .

echo "→ Rebuilding bat cache…"
bat cache --build

echo "→ Setting Git defaults…"
git config --global core.editor nvim                         2>/dev/null || true
git config --global pull.rebase true                         2>/dev/null || true
git config --global push.autoSetupRemote true
git config --global include.path ~/.config/delta-themes.gitconfig
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.features poimandres
git config --global delta.navigate true
git config --global merge.conflictStyle zdiff3
git config --global delta.hyperlinks true
git config --global delta.hyperlinks-file-link-format 'zed://file/{path}:{line}'
git config --global delta.colorMoved default

echo "✓ All done – open a new shell!"
          '';
        };
      in {
        packages.pkg-set = pkg-set;                                     # nix profile install .#pkg-set
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
