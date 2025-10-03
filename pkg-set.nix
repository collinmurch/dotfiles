{ pkgs, pkgs-unstable }:
let
  #
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
    # bitwarden-cli
    age
    ssh-to-age
    nil
    nixd
    uv
    bun
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

  guiApplications = with pkgs; [
    ### gui applications (require allowUnfree = true)
    # zed-editor
    # raycast
  ];

  basePackages = tools ++ fonts ++ zshPlugins ++ guiApplications;
in
basePackages
