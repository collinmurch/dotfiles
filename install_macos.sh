#!/bin/zsh

#
# Homebrew
#

brew install nushell uv
brew install zsh-syntax-highlighting zsh-autosuggestions

brew install stow neovim bat starship
brew install ripgrep jq git-delta

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

#
# Git configuration
#

# Set editor to nvim
git config --global core.editor nvim

# Set pull to rebase by default
git config --global pull.rebase true

# Set push to create upstream branch automatically
git config --global push.autoSetupRemote true

# Configure delta as pager (themes file will be symlinked by stow)
git config --global include.path ~/.config/delta-themes.gitconfig
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.features poimandres
git config --global delta.navigate true
git config --global merge.conflictStyle zdiff3
