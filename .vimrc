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
Plugin 'gmarik/vundle'           " Vundle
Plugin 'ervandew/supertab'       " magic with TAB
Plugin 'screen.vim'              " something I don't exactly know how to use
Plugin 'tComment'                " language-aware commenting
Plugin 'Distinguished'           " may main colorscheme (256 bit)
Plugin 'Vim-R-plugin'            " R code wrapper
" Plugin 'jalvesaq/R-vim-runtime "
Plugin 'Python-mode-klen'        " python wrapping etc
" Plugin 'ivanov/vim-ipython'    " **
Plugin 'LaTeX-Box'               " latex wrapping, keybinding, etc.
Plugin 'SirVer/ultisnips'        " snippet engine
Plugin 'honza/vim-snippets'      " snippets use be ultisnips engine
Plugin 'Gundo'                   " * undo tree, <F5> to open
Plugin 'Shougo/vinarise'         " hex editor
Plugin 'reedes/vim-pencil'       " allows autowrapping for writing
" Plugin 'jpalardy/vim-slime'    " copy and paste into another tmux window
Plugin 'davidhalter/jedi-vim'    " for autocomplete
Plugin 'junegunn/goyo.vim'       " zen mode

" * requires compilation with --enable-pythoninterp flag set
" ** requires installation of ipython
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
" nnoremap <SID>annoying_latex_thing_cj <Plug>IMAP_JumpForward

" --- remove the annoying ESC delay ---
" NOTE: if you are using tmux, you will also need to add the following command
" to your .tmux.conf file:
" set -s escape-time 0
set timeoutlen=1000 ttimeoutlen=0


filetype plugin on
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
" YouCompleteMe options
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vinarise options
let g:vinarise_enable_auto_detect=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pencil options
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Goyo options
function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  set nonumber
  set scrolloff=999
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
  set number
  set scrolloff=5
endfunction

" Quitting whether Goyo is active or not
" - junegunn: https://github.com/junegunn/goyo.vim/issues/16
function! g:GoyoBefore()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

" - junegunn
function! g:GoyoAfter()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

" - junegunn
let g:goyo_callbacks = [function('g:GoyoBefore'), function('g:GoyoAfter')]

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dealing with particular file types
autocmd BufNewFile,BufRead *.csv,*.tsv,*.tab call TabularSettings()
autocmd BufNewFile,BufRead *.R call RSettings()
autocmd FileType text call TextSettings()
autocmd FileType tex call LatexSettings()
autocmd FileType markdown call MarkdownSettings()
autocmd FileType html,tex,Rnw call TwoStop()
autocmd FileType py call PythonSetting()

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
    setlocal expandtab
    map <buffer> <leader> h RAction("head")
endfunction

function! TwoStop()
    setlocal tabstop=2
    setlocal shiftwidth=2
endfunction

function! TextSettings()
    setlocal spell
    setlocal nonumber
endfunction

function! MarkdownSettings()
    " add row of '=' beneath header
    noremap <leader>h yypVr=
endfunction

function! PythonSetting()
    let g:slime_target = "tmux"
    let g:slime_paste_file = tempname()
    let g:slime_python_ipython = 1

    " let g:pymode_***
    " jedi-vim does the same thing as ropes, but faster?
    " nmap <buffer> <C-CR> <Plug>SlimeLineSend
    " vmap <buffer> <C-CR> <Plug>SlimeRegionSend
endfunction
