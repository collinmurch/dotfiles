{ pkgs }:
with pkgs; [
  # core shells/tools
  nushell  stow  neovim  helix  bat
  ripgrep  starship  jq  delta

  # languages
  nil  nixd  uv

  # zsh plugins
  zsh-syntax-highlighting    zsh-autosuggestions

  # gui applications (require allowUnfree = true)
  # raycast  zed-editor  vscode
]
