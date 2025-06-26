#!/bin/zsh

#
# Homebrew
#

brew install nushell uv
brew install zsh-syntax-highlighting zsh-autosuggestions

brew install stow neovim bat starship
brew install ripgrep jq

brew install --cask raycast
brew install --cask ghostty
brew install --cask zed
brew install --cask visual-studio-code


#
# Etc.
#

uv tool install pyrefly


#
# Below must be run from dotfiles directory
#


# stow ~/dotfiles to ~
stow --no-folding -d ~/dotfiles -t ~ .

# rebuild bat cache with our custom theme
bat cache --build
