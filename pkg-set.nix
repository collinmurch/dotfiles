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
    bitwarden-cli 
    age 
    ssh-to-age
    nil 
    nixd 
    uv
  ];

  fonts = with pkgs; [
    jetbrains-mono
  ];

  zshPlugins = with pkgs; [
    zsh-syntax-highlighting zsh-autosuggestions
  ];

  guiApplications = with pkgs; [
    ### gui applications (require allowUnfree = true)
    # raycast  zed-editor  vscode
  ];

  basePackages = tools ++ fonts ++ zshPlugins ++ guiApplications;
in
basePackages
