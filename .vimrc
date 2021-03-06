" collinmurch's .vimrc
" github.com/collinmurch
	
" Color configs
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set t_ZH=^[[3m
set t_ZR=^[[23m
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

" Plug Settings
call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree'
	Plug 'preservim/nerdcommenter'
	Plug 'morhetz/gruvbox'
	Plug 'drewtempelmeyer/palenight.vim'
	Plug 'tpope/vim-surround'
	Plug 'ryanoasis/vim-devicons'
call plug#end()

" Macros and Keybinds
noremap ;s :source ~/.vimrc<cr>

inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O<BS>
inoremap {{     {
inoremap {}     {}

" NERDTree Settings
map <silent> <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

" NERDCommenter Settings

" Customizations
colorscheme palenight
hi Comment cterm=italic
hi String cterm=italic
hi Normal ctermbg=none
hi Normal guibg=none
let g:palenight_terminal_italics=1
filetype plugin on
filetype indent on
set nocompatible
set encoding=UTF-8
set guifont=Meslo_LG_L_Regular_Nerd_Font_Complete:h18
set backspace=2
set background=dark
set tabstop=4
set shiftwidth=4
set relativenumber
set ignorecase


" Reset cursor
au VimEnter,VimResume * set guicursor=n-v-c:hor20,i-ci-ve:ver20,r-cr:hor20,o:hor50
au VimLeave,VimSuspend * set guicursor=a:hor
