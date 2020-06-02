set nocompatible
filetype off "required, for vundle

if has("win32" || "win64")
	set encoding=utf-8 "required for YouCompleteMe
	set rtp+=$HOME/.vim/bundle/Vundle.vim/
	call vundle#begin('$HOME/.vim/bundle/')
else
	if has("unix")
		let s:uname = system("name")
		if s:uname == "Darwin\n"
			set rtp+=~/.vim/bundle/Vundle.vim
			call vundle#begin()
		endif
	endif
endif

Plugin 'scrooloose/nerdtree'
Plugin 'flazz/vim-colorschemes'
Plugin 'VundleVim/Vundle.vim' "required
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
vnoremap < <gv " better indentation
vnoremap > >gv " better indentation

