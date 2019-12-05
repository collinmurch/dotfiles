" collinmurch's .vimrc
" github.com/collinmurch

" Customizations
filetype plugin on
filetype indent on
set nocompatible
set background=dark
set encoding=UTF-8
set guifont=Meslo_LG_L_Regular_Nerd_Font_Complete:h18
set number
set backspace=2
set background=dark
set tabstop=4
set relativenumber
set ignorecase

" Color configs
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" Plug Settings
call plug#begin('~/.vim/plugged')
	Plug 'scrooloose/nerdtree'
	Plug 'morhetz/gruvbox'
	Plug 'drewtempelmeyer/palenight.vim'
	Plug 'tpope/vim-surround'
	Plug 'ryanoasis/vim-devicons'
call plug#end()

" Macros / Keybinds
noremap ;s :source ~/.vimrc<cr>

autocmd FileType html noremap ;b i<body></body><Esc>F<i<CR><CR><Up><Tab>
autocmd FileType html noremap ;h i<head></head><Esc>F<i<CR><CR><Up><Tab>
autocmd FileType html noremap ;p i<p></p><esc>F<i
autocmd FileType html noremap ;i i<img src=""></img><Esc>F"i

" Adding closing '{'
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O<BS>
inoremap {{     {
inoremap {}     {}

" NERDTree Settings
map <silent> <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

" Customizations 2 (loaded after everything)

colorscheme palenight
" let g:palenight_terminal_italics=1
" hi Comment cterm=italic
" hi String cterm=italic
" hi Normal ctermbg=none

