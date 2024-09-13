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

# Blinking bar as cursor
echo -n '\e[5 q'

# Highlight current tab selection
autoload -U compinit
compinit
zstyle ':completion:*' menu select

# Zsh autocomplete with tab
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
setopt no_list_ambiguous

# Plugins
eval "$(starship init zsh)"
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/plugins/zsh-shift-select.zsh
