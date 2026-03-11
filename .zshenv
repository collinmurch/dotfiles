export DEV=$HOME/Developer

export BAT_THEME="Poimandres"
export EDITOR="zed --wait"

export GOPATH="$HOME/go"
export PYTHONPATH="$DEV/python"

export PATH=$PATH:$DEV/scripts

export PATH=:$PATH:/usr/local/bin
export PATH=:$PATH:/opt/homebrew/bin

export PATH=$PATH:/nix/var/nix/profiles/default/bin
export PATH=$PATH:$HOME/.nix-profile/bin

export PATH=$PATH:$HOME/.cache/lm-studio/bin
export PATH=$PATH:$HOME/.local/bin

export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.cargo/bin

# Load shared env vars (KEY=VALUE format)
set -a
[ -f "$HOME/.env" ] && source "$HOME/.env"
set +a
