#!/bin/zsh

brew install nushell
brew install zsh-syntax-highlighting zsh-autosuggestions

brew install stow neovim bat starship
brew install ripgrep jq

brew install --cask raycast
brew install --cask ghostty
brew install --cask visual-studio-code
brew install --cask zed

# Create local.nu if it doesn't exist so we don't get an error
# TODO: Find a better way to do machine-specific config
nu -c "if (not ('$(nu -c 'echo $nu.config-path | path dirname')/local.nu' | path exists)) { '' | save '$config_dir/local.nu' }"
