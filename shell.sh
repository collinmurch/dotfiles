# Check that working directory is dotfiles
if [ $(echo "$PWD" | python -c "import sys; print \"yes\" if \"dotfiles\" in sys.stdin.read().split(\"/\")[-1] else \"no\"") != "yes" ]; then
	echo "dotfiles must be current working directory.";
    exit;
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing sudo time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Give the user a final option to cancel
i=0; while [[ $i -lt 10 ]]; do echo "Beginning script in $((10 - i))"; ((i++)); sleep 1; done

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Update casks and upgrade formulae
brew update && brew upgrade

# Install needed homebrew binaries
brew install node
brew install python3
brew install neofetch
brew install htop
brew install gcc
brew install binwalk
brew install aircrack-ng
brew install nmap
brew install tesseract

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install zsh syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Install NERDTREE-compliant vim, and override system vim
brew install vim --with-override-system-vi

# Install nerd-fonts
git clone https://github.com/ryanoasis/nerd-fonts ~/Desktop/nerdfonts
~/Desktop/nerdfonts/install.sh
rm -rf ~/Desktop/nerdfonts

# Install plug for vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install pathogen for vim
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install NERDTREE
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

# Globally install nodemon from npm
npm install -g nodemon

# Move zsh theme to themes
cat ./collin.zsh-theme > ~/.oh-my-zsh/themes/collin.zsh-theme

# Update startup files
cat ./zshrc.txt > ~/.zshrc
cat ./vimrc.txt > ~/.vimrc