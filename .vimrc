set nocompatible
filetype off

" Reset any autocmd
autocmd!

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEGIN VUNDLE
" :PluginInstall - to install plugins
" :PluginUpdate  - to update
" :PluginSearch  - list all plugins in vim script
" :PluginClean   - remove plugins not mentioned below
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'          " Vundle
Plugin 'ervandew/supertab'      " magic with TAB
Plugin 'screen.vim'             " something I don't exactly know how to use
Plugin 'tComment'               " language-aware commenting
Plugin 'Distinguished'          " may main colorscheme (256 bit)
Plugin 'Vim-R-plugin'           " R code wrapper
Plugin 'Python-mode-klen'       " python wrapping
Plugin 'LaTeX-Box'              " latex wrapping, keybinding, etc.
Plugin 'SirVer/ultisnips'       " snippet engine
Plugin 'honza/vim-snippets'     " snippets use be ultisnips engine
Plugin 'Gundo'                  " undo tree, <F5> to open
Plugin 'Shougo/vinarise'        " hex editor
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global mapping
noremap ; :
noremap : ;

" select a word with space
noremap <space> viw

" press enter to reset highlighting
nnoremap <CR> :noh<CR><CR>

" wrap paragraph
nnoremap <leader>p ma{V}gq'a$

" search for selected text
vnoremap // y/<C-R>"<CR>

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
set number
set scrolloff=5
set shiftwidth=4
set smartcase
set smarttab
set syntax=automatic
set tabstop=4
set shiftwidth=4
set wildmode=longest,list
autocmd BufNewFile,BufRead *.tex set syn=tex
nnoremap <SID>annoying_latex_thing_cj <Plug>IMAP_JumpForward

syntax on

" To turn on 256 bit colors and the awesome distinguished theme, uncomment
" the lines below. Note that 256 bit color may require setting on parameters
" in your kernel, or something.
" -------
set t_Co=256
colorscheme distinguished


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snippet commands - for use with ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="horizontal"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gundo options
nnoremap <F5> :GundoToggle<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vinarise options
let g:vinarise_enable_auto_detect=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dealing with particular file types
autocmd BufNewFile,BufRead *.csv,*.tsv,*.tab call TabularSettings()
autocmd BufNewFile,BufRead *.R call RSettings()
autocmd FileType text call TextSettings()
autocmd FileType tex call LatexSettings()
autocmd FileType markdown call MarkdownSettings()
autocmd FileType html,tex call TwoStop()

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

function! TwoStop()
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
