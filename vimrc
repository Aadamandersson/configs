set nocompatible
filetype off "required, for vundle

if has("win32") || has("win64")
	"set encoding=utf-8 "required for YouCompleteMe
	set rtp+=$HOME/.vim/bundle/Vundle.vim/
	call vundle#begin('$HOME/.vim/bundle/')
	"call vundle#config#require(g:bundles)
else
	if has("unix")
		let s:uname = system("uname")
		if s:uname == "Darwin\n"
			set rtp+=~/.vim/bundle/Vundle.vim
			call vundle#begin()
		endif
	endif
endif

Plugin 'VundleVim/Vundle.vim' "required
"Plugin 'neoclide/coc.nvim', {'branch': 'release'}
"Plugin 'vim-scripts/AutoComplPop'
Plugin 'scrooloose/nerdtree'
Plugin 'flazz/vim-colorschemes'

call vundle#end() "required, all plugins must be added before this line
filetype indent plugin on

colorscheme vividchalk

let NERDTreeIgnore = ['__pycache__', '\.pyc$', '\.o$', '\.so$', '\.a$', '\.swp', '*\.swp', '\.swo', '\.swn', '\.swh', '\.swm', '\.swl', '\.swk', '\.sw*$', '[a-zA-Z]*egg[a-zA-Z]*', '.DS_Store']
" open nerdtree with ctrl-n
let g:NerdTreeWinpos="left"
map <C-n> :NERDTreeToggle<CR>
syntax on
set t_Co=256 " 256 colormode in terminal
set background=dark
set showmatch " show matching brackets/paranthesis
set tabstop=4
set number
set autoindent
set shiftwidth=4
set pastetoggle=<F12>
set clipboard=unnamed
set mouse =a
set bs=2 "make backspace behave like normal
set shortmess+=c
highlight Pmenu ctermbg=black guibg=black "black bg color (ctrl+p or n)

"set complete+=kspell
"set completeopt=menuone,longest

" Navigate the complete menu items (CTRL+n / CTRL+p)
"inorepmap <expr> <Down> pumvisible() ? "<C-n>" : "<Down>"
"inorepmap <expr> <Up> pumvisible() ? "<C-p>" : "<Up>"

" Select the complete menu item (CTRL+y)
"inorepmap <expr> <Right> pumvisible() ? "<C-y>" : "<Right>"
"inorepmap <expr> <CR> pumvisible() ? "<C-y>" : "<CR>"

" Cancel the complete menu item (CTRL+e)
"inorepmap <expr> <Left> pumvisible() ? "<C-e>" : "<Left>"


vnoremap < <gv " better indentation
vnoremap > >gv " better indentation

