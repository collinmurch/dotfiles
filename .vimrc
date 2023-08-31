" collinmurch's .vimrc
" github.com/collinmurch

" Plug Settings
call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree'
	Plug 'preservim/nerdcommenter'
	Plug 'morhetz/gruvbox'
	Plug 'drewtempelmeyer/palenight.vim'
	Plug 'tpope/vim-surround'
	Plug 'ryanoasis/vim-devicons'
	Plug 'yuezk/vim-js'
	Plug 'MaxMEllon/vim-jsx-pretty'
	Plug 'vim-python/python-syntax'
call plug#end()

" Color Configs
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

" Macros and Keybinds
noremap ;s :source ~/.vimrc<cr>

" NERDTree Settings
map <silent> <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

" Customizations
colorscheme palenight
hi Comment cterm=italic
hi String cterm=italic
hi Normal ctermbg=NONE
let g:palenight_terminal_italics=1
let g:python_highlight_all = 1
filetype plugin on
filetype indent on
set nocompatible
set encoding=UTF-8
set guifont=Meslo_LG_L_Regular_Nerd_Font_Complete:h18
set backspace=2
set background=dark
set tabstop=4
set shiftwidth=4
set nu
let mapleader = ","
set ignorecase
hi Normal guibg=NONE
set mouse=a

" Set/Reset Cursor
au VimEnter,VimResume * set guicursor=n-v-c:hor20,i-ci-ve:ver20,r-cr:hor20,o:hor50
"au VimLeave,VimSuspend * set guicursor=a:hor
