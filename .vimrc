"collinmurch's .vimrc
" github.com/collinmurch

" Plug Settings
call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree'
	Plug 'morhetz/gruvbox'
	Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
	Plug 'ryanoasis/vim-devicons'
call plug#end()

" Color Configs
colorscheme catppuccin

" Macros and Keybinds
noremap ;s :source ~/.vimrc<cr>

" NERDTree Settings
map <silent> <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

" Customizations
hi Normal guibg=NONE
hi Comment cterm=italic
set encoding=UTF-8

set backspace=2
set background=dark
set tabstop=4
set shiftwidth=4
set relativenumber
set ignorecase
set mouse=a

filetype plugin on
filetype indent on
