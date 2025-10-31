{ pkgs, ... }:
let

  # required for dotfiles
  tools = with pkgs; [
    nushell
    stow
    neovim
    helix
    bat
    ripgrep
    starship
    delta
    fzf
    bitwarden-cli
    age
    ssh-to-age
    nil
    nixd
    imagemagick
    emacsPackages.pbcopy
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
