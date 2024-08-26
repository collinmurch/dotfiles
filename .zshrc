alias vim="nvim"
alias cat="bat -p"
alias ls="ls --color"

alias dev='cd $DEV'
alias godev='cd $DEV/go/src'
alias school='cd $HOME/Documents/iCloud\ Drive/Documents/School/'

eval "$(starship init zsh)"
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
