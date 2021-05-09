set nocompatible
filetype off
let mapleader = "\<Space>"
call plug#begin(stdpath('data'))

Plug 'w0rp/ale'
Plug 'flazz/vim-colorschemes'
Plug 'itchyny/lightline.vim'
Plug 'justinmk/vim-sneak'
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

syntax on
set background=dark
colorscheme jellybeans
if !has('gui_running')
	set t_Co=256
endif
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
	set termguicolors
endif
if has("nvim-0.5.0") || has("patch-8.1.1564")
  	set signcolumn=number
else
  	set signcolumn=yes
endif

filetype plugin indent on
set showmatch
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set scrolloff=2
set autoindent
set number
set mouse=a
set bs=2
set undodir=~/.vimdid
set undofile
set encoding=utf-8
set printencoding=utf-8
set colorcolumn=80
set shortmess+=c
set cmdheight=2
set updatetime=300
set laststatus=2
set showcmd " Show (partial) command in status line.
set hidden
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,*.min.js,*.swp,,*.o,
set nofoldenable
set ttyfast
set lazyredraw
set synmaxcol=500
set nowrap
set nojoinspaces
set noshowmode

" Sane splits..
set splitright
set splitbelow

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
	let col = col('.') - 1
  	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

" Use <c-.> to trigger completion.
inoremap <silent><expr> <c-.> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Show actions available at this location
nnoremap <silent> <space>a  :CocAction<cr>

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>
" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

noremap <leader>s :Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


" Lightline
let g:lightline = {
    \ 'colorscheme' : 'jellybeans',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'filename': 'LightlineFilename',
    \   'cocstatus': 'coc#status'
    \ },
\ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Rust
let g:rustfmt_autosave=1
au Filetype rust set colorcolumn=100

" C#
let g:coc_global_extensions=['coc-omnisharp']
au Filetype cs set colorcolumn=120


map <C-p> :Files<CR>
map <leader>; :Buffers<CR>
let g:fzf_layout = { 'down': '~20%' }

vnoremap < <gv
vnoremap > >gv

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
