{ pkgs, pkgs-unstable, ... }:
let

  # required for dotfiles
  tools = with pkgs; [
    pkgs-unstable.nushell
    stow
    helix
    bat
    ripgrep
    jujutsu
    delta
    fzf
    bitwarden-cli
    age
    ssh-to-age
    nil
    nixd
    imagemagick
    emacsPackages.pbcopy
    texlive.combined.scheme-full
  ];

  fonts = with pkgs; [
    jetbrains-mono
  ];

  basePackages = tools ++ fonts;
in
basePackages
