export DEV=$HOME/Developer

export BAT_THEME="Poimandres"
export EDITOR="zed --wait"

export GOPATH="$HOME/go"
export PYTHONPATH="$DEV/python"

export PATH=$PATH:$DEV/scripts

export PATH=:$PATH:/usr/local/bin
export PATH=:$PATH:/opt/homebrew/bin

export PATH=$PATH:$HOME/.cache/lm-studio/bin
export PATH=$PATH:$HOME/.local/bin

export PATH=$PATH:$GOPATH/bin
export PATH="$HOME/.cargo/bin:$PATH"

# Nix setup
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
fi

# Load shared env vars (KEY=VALUE format)
set -a
[ -f "$HOME/.env" ] && source "$HOME/.env"
set +a
