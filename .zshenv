export HOMEBREW_PREFIX=/opt/homebrew
export DEV=$HOME/Developer

export PATH=$HOMEBREW_PREFIX/bin:$PATH

export GOPATH="$DEV/go"
export GOROOT="$(brew --prefix go)/libexec"

export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$DEV/scripts
export PATH=$PATH:$GOROOT/bin

export BAT_THEME="Poimandres"
