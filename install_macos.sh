#!/bin/zsh


brew install nushell
brew install zsh-syntax-highlighting zsh-autosuggestions

brew install stow neovim bat starship
brew install ripgrep jq

brew install --cask raycast
brew install --cask ghostty
brew install --cask zed
brew install --cask visual-studio-code


#
# Below must be run from dotfiles directory
#

# nushell config.nu depends on local.nu existing
cp ./Library/Application\ Support/nushell/local.template.nu ./Library/Application\ Support/nushell/local.nu

# stow ~/dotfiles to ~
stow --no-folding -d ~/dotfiles -t ~ .

# rebuild bat cache with our custom theme
bat cache --build
