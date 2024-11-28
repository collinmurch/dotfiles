export HOMEBREW_PREFIX="/opt/homebrew"
export DEV=$HOME/Developer

export PATH=/opt/homebrew/bin:$PATH
export PATH=$PATH:$DEV/scripts
export PATH=$PATH:$DEV/go/bin

export GOPATH="$DEV/go"
export GOROOT="$(brew --prefix go)/libexec"

export BAT_THEME="Poimandres"
