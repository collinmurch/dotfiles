export HOMEBREW_PREFIX=/opt/homebrew
export DEV=$HOME/Developer

export PATH=$HOMEBREW_PREFIX/bin:$PATH
export PATH=$PATH:$DEV/scripts

export BAT_THEME="Poimandres"
export EDITOR="zed --wait"

export GOPATH="$HOME/go"
export GOROOT="$(brew --prefix go)/libexec"

export PYTHONPATH="$DEV/python"

export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.cache/lm-studio/bin
