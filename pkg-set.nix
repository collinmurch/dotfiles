{ pkgs, pkgs-unstable }:
let
  # Package groups
  coreTools = with pkgs; [
    nushell stow neovim helix bat
    ripgrep starship jq delta fzf
  ];

  devTools = with pkgs; [
    nil nixd uv age ssh-to-age bitwarden-cli
  ];

  zshPlugins = with pkgs; [
    zsh-syntax-highlighting zsh-autosuggestions
  ];

  basePackages = coreTools ++ devTools ++ zshPlugins;
in
basePackages ++ [
  # gui applications (require allowUnfree = true)
  # raycast  zed-editor  vscode
]
