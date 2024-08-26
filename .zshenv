export DEV=$HOME/Developer

export PATH=$PATH:/opt/homebrew/bin
export PATH=$PATH:$DEV/scripts

export GOPATH="$DEV/go"
export GOROOT="$(brew --prefix go)/libexec"
source $HOME/.cargo/env

export ZSH_THEME="collin"
export BAT_THEME="Catppuccin Mocha"
export ZSH=$HOME/.oh-my-zsh
