#!/bin/zsh

brew install stow neovim bat starship                       # cli
brew install ripgrep lua-language-server                    # neovim
brew install zsh-syntax-highlighting zsh-autosuggestions    # zsh

brew install --cask font-jetbrains-mono

brew install --cask raycast
brew install --cask wezterm
brew install --cask visual-studio-code
brew install --cask zed

git config --global core.editor "nvim"
git config --global merge.tool "nvimdiff3"
