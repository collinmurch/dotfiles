alias cat="bat -p"
alias ls="ls --color"
alias dev='cd $DEV'
alias godev='cd $DEV/go'

# Blinking bar as cursor
echo -n '\e[5 q'

# Highlight current tab selection
autoload -U compinit
compinit
zstyle ':completion:*' menu select

# Zsh autocomplete with tab
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
setopt no_list_ambiguous
