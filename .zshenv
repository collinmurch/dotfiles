export HOMEBREW_PREFIX="/opt/homebrew"
export DEV=$HOME/Developer

export GOPATH="$DEV/go"
export GOROOT="$(brew --prefix go)/libexec"

export PATH=/opt/homebrew/bin:$PATH
export PATH=$PATH:$DEV/scripts
export PATH=$PATH:$GODEV/bin

export BAT_THEME="Poimandres"
