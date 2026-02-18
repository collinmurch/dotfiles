#
# Aliases
#

alias vim="nvim"
alias cat="bat -p"
alias ls="ls --color"
jj() {
    if [[ "$1" == "workspace" && ("$2" == "rm" || "$2" == "remove") ]]; then
        command jj workspace forget "$3" && rm -rf "../$3"
    else
        command jj "$@"
    fi
}

alias dev='cd $DEV'
alias godev='cd $DEV/go'


#
# Configuration
#

# Blinking bar as cursor
echo -n '\e[5 q'

# Highlight current tab selection
autoload -U compinit
compinit
zstyle ':completion:*' menu select

# Zsh autocomplete with tab
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
setopt no_list_ambiguous

# Nix setup
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
fi
