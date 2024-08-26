export DEV=$HOME/Developer

export PATH=$PATH:/opt/homebrew/bin
export PATH=$PATH:$DEV/scripts

export GOPATH="$DEV/go"
export GOROOT="$(brew --prefix go)/libexec"
source $HOME/.cargo/env

export BAT_THEME="Catppuccin Mocha"
