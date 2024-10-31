#!/bin/zsh

brew install stow
brew install neovim
brew install ripgrep                    # For vim-telescope
brew install lua-language-server gopls  # For nvim config editing
brew install starship
brew install bat
brew install zsh-syntax-highlighting
brew install zsh-autosuggestions

brew install --cask font-jetbrains-mono

brew install raycast --cask
brew install wezterm --cask
brew install visual-studio-code --cask
brew install zed --cask

git config --global core.editor "nvim"
git config --global merge.tool "nvimdiff3"
