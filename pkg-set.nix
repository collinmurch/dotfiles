{ pkgs, pkgs-unstable, ... }:
let

  # required for dotfiles
  tools = with pkgs; [
    pkgs-unstable.nushell
    stow
    neovim
    helix
    bat
    ripgrep
    starship
    delta
    jujutsu
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

  zshPlugins = with pkgs; [
    zsh-syntax-highlighting
    zsh-autosuggestions
  ];

  basePackages = tools ++ fonts ++ zshPlugins;
in
basePackages
