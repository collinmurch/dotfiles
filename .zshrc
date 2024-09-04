#
# Environment variables
#

export DEV=$HOME/Developer

export PATH=$PATH:/opt/homebrew/bin
export PATH=$PATH:$DEV/scripts

export GOPATH="$DEV/go"
export GOROOT="$(brew --prefix go)/libexec"

export BAT_THEME="Catppuccin Mocha"


#
# Aliases
#

alias vim="nvim"
alias cat="bat -p"
alias ls="ls --color"

alias dev='cd $DEV'
alias godev='cd $DEV/go/src'
alias school='cd $HOME/Documents/iCloud\ Drive/Documents/School/'


# 
# Configuration
#

eval "$(starship init zsh)"
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Blinking bar as cursor
echo -n '\e[5 q' 

# Highlight current tab selection
autoload -U compinit
compinit
zstyle ':completion:*' menu select

# Case insensitivity for zsh autocomplete
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt no_list_ambiguous