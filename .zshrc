export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="collin"

plugins=(
  git
  osx
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

alias dev='cd ~/Documents/developer'
alias school='cd /Users/collinmurch/Sync/Documents/School/Freshman\ Fall/'
alias cdgo='cd ~/Documents/developer/go/src'

alias clean='~/Documents/developer/scripts/cleantex.sh'
alias sailserver='sudo ssh admin@54.184.108.207 -i ~/.ssh/aws/LightsailDefaultPrivateKey-us-west-2.pem'

alias jupyter='/usr/local/bin/jupyter'
alias word='open -a /Applications/"Microsoft Word.app"'
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
alias ssh='TERM=xterm-256color ssh'

export PATH="/usr/local/sbin:$PATH"
export GOPATH=$HOME/Documents/developer/go
export PATH=$PATH:/Applications/Racket\ v7.4/bin/
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export BAT_THEME="OneHalfDark"
