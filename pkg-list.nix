{ pkgs, system }:
with pkgs; [
  # core shells/tools
  nushell  stow  neovim  helix  bat  starship
  ripgrep  jq  delta  nil  nixd  uv  ty

  # zsh plugins
  zsh-syntax-highlighting    zsh-autosuggestions

  # GUI applications (require allowUnfree = true)
  # raycast  zed-editor  vscode
]
