" Reset any autocmd
autocmd!


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pathogen
filetype off " Pathogen needs to run before plugin indent on
call pathogen#incubate()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global mapping
let mapleader=";"
let maplocalleader=","

" Map window switching
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" select a word with space
noremap <space> viw

" reset highlighting
nnoremap <CR> :noh<CR><CR>

" noun: v from vimrc, s for shellrc, a for aliase file
" verb: e for edit and s for source
noremap <leader>ve :split $VIMRC<cr>
noremap <leader>se :split $BASHRC<cr>
noremap <leader>ae :split $BASH_ALIASES<cr>
noremap <leader>vs :source $VIMRC<cr>
noremap <leader>ss :source $BASHRC<cr>
noremap <leader>as :source $BASH_ALIASES<cr>
noremap <leader>' bi'<esc>ea'<esc>
noremap <leader>" bi"<esc>ea"<esc>
" wrap paragraph
nnoremap <leader>p ma{V}gq'a$

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
set winheight=40
set backspace=indent,eol,start
set ai
" Visual blocks automatically written to system clipboard
set clipboard^=autoselect
set expandtab
set hlsearch
set ignorecase
set incsearch
set noswapfile
set relativenumber
set number
set scrolloff=5
set shiftwidth=4
set smartcase
set smarttab
set syntax=automatic
set t_Co=256
set tabstop=4
set shiftwidth=4
set wildmode=longest,list
autocmd BufNewFile,BufRead *.tex set syn=tex
nnoremap <SID>annoying_latex_thing_cj <Plug>IMAP_JumpForward

syntax on
colorscheme distinguished


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dealing with particular file types
autocmd BufNewFile,BufRead *.csv,*.tsv,*.tab call TabularSettings()
autocmd BufNewFile,BufRead *.R call RSettings()
autocmd FileType text call TextSettings()
autocmd FileType tex call LatexSettings()
autocmd FileType markdown call MarkdownSettings()

function! TabularSettings()
    setlocal nowrap
endfunction

function! LatexSettings()
    setlocal syn=tex
endfunction

function! RSettings()
    setlocal syn=r
    setlocal tabstop=2
    setlocal shiftwidth=2
endfunction

function! TextSettings()
    setlocal spell
    setlocal wrap
endfunction

function! MarkdownSettings()
    " add row of '=' beneath header
    noremap <leader>h yypVr=
endfunction
