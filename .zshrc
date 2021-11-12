export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="collin"

plugins=(
  git
  macos
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

alias vim="nvim"

alias eecs='~/Documents/developer/scripts/eecs.sh'

# For win32 asm development
alias windows='echo "Attempting to connect to Windows 10 VM..." && ssh collinmurch@deathtumble.local'
CE205=collinmurch@deathtumble.local:C:/Users/collinmurch/Documents/COMP_ENG_205

alias dev='cd ~/Documents/developer'
alias school='cd /Users/collinmurch/Documents/iCloud\ Drive/Documents/School/Junior\ Fall'
alias cdgo='cd ~/Documents/developer/go/src'

alias newdoc='~/Documents/developer/scripts/newtexdoc.sh'
alias clean='~/Documents/developer/scripts/cleantex.sh'
alias sailserver='sudo ssh ubuntu@34.218.34.252 -i ~/.ssh/aws/LightsailDefaultPrivateKey-us-west-2.pem'
alias minecraft='ssh root@31.220.109.41'

alias jupyter='/usr/local/bin/jupyter'
alias word='open -a /Applications/"Microsoft Word.app"'
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
alias ssh='TERM=xterm-256color ssh'
alias pyenv='source ~/.env/bin/activate'

export PATH="/usr/local/sbin:$PATH"
export GOPATH=$HOME/Documents/developer/go
export PATH=$PATH:/Applications/Racket\ v7.4/bin/
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export BAT_THEME="OneHalfDark"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

