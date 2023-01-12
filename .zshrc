export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="collin"

plugins=(
  git
  macos
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

alias vim="nvim"

VMIP=""

# For win32 asm development
alias windows='echo "Attempting to connect to Windows 10 VM..." && ssh collinmurch@deathtumble.local'

alias dev='cd ~/Documents/developer'
alias school='cd ~/Documents/iCloud\ Drive/Documents/School/Senior\ Winter'
alias newdoc='~/Documents/developer/scripts/newtexdoc.sh'
alias clean='~/Documents/developer/scripts/cleantex.sh'


alias sailserver='sudo ssh ubuntu@34.218.34.252 -i ~/.ssh/aws/LightsailDefaultKey-us-west-2.pem'

alias vm='sudo ssh ubuntu@$VMIP -i ~/.ssh/aws/collin-396.pem'
alias scpvm='function f(){ sudo scp -i ~/.ssh/aws/collin-396.pem $1 ubuntu@$VMIP:~;}; f'

alias word='open -a /Applications/"Microsoft Word.app"'
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
alias ssh='TERM=xterm-256color ssh'
alias pyenv='source ~/.env/bin/activate'

export PATH="/usr/local/sbin:$PATH"
export GOPATH=$HOME/Documents/developer/go
export PATH=$PATH:/Applications/Racket\ v7.4/bin/
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export BAT_THEME="OneHalfDark"
