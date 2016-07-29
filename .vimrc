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
Plugin 'gmarik/vundle'                " Vundle
Plugin 'ervandew/supertab'            " magic with TAB
Plugin 'screen.vim'                   " something I don't exactly know how to use
Plugin 'tComment'                     " language-aware commenting
Plugin 'Distinguished'                " may main colorscheme (256 bit)
Plugin 'Vim-R-plugin'                 " R code wrapper
" Plugin 'jalvesaq/R-vim-runtime      "
Plugin 'Python-mode-klen'             " python wrapping etc
" Plugin 'ivanov/vim-ipython'         " **
Plugin 'LaTeX-Box'                    " latex wrapping, keybinding, etc.
Plugin 'SirVer/ultisnips'             " snippet engine
Plugin 'honza/vim-snippets'           " snippets use be ultisnips engine
Plugin 'Gundo'                        " * undo tree, <F5> to open
Plugin 'Shougo/vinarise'              " hex editor
Plugin 'reedes/vim-pencil'            " allows autowrapping for writing
" Plugin 'jpalardy/vim-slime'         " copy and paste into another tmux window
" Plugin 'davidhalter/jedi-vim'         " for autocomplete
Plugin 'junegunn/goyo.vim'            " zen mode
Plugin 'vim-scripts/Conque-GDB'       " sync vim and GNU Debugger
Plugin 'airblade/vim-gitgutter'       " shows changes to git file
Plugin 'majutsushi/tagbar'            " ctag code outline bar
Plugin 'ap/vim-buftabline'            " show buffers
Plugin 'scrooloose/nerdtree'          " filesystem browser
Plugin 'Xuyuanp/nerdtree-git-plugin'  " git flag integration with NerdTree
Plugin 'vim-scripts/Align'            " align based on a character
Plugin 'tpope/vim-fugitive'           " manage git
Plugin 'ctrlpvim/ctrlp.vim'           " CtrlP

" * requires compilation with --enable-pythoninterp flag set
" ** requires installation of ipython
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global mapping
noremap ; :
noremap : ;

" set default shell - needed for nerdtree-git-plugin
set shell=sh

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
" autocmd BufNewFile,BufRead *.tex set syn=tex
" nnoremap <SID>annoying_latex_thing_cj <Plug>IMAP_JumpForward

" --- remove the annoying ESC delay ---
" NOTE: if you are using tmux, you will also need to add the following command
" to your .tmux.conf file:
" set -s escape-time 0
set timeoutlen=200 ttimeoutlen=0

filetype plugin on
syntax on

" To turn on 256 bit colors and the awesome distinguished theme, uncomment
" the lines below. Note that 256 bit color may require setting on parameters
" in your kernel, or something.
" -------
set t_Co=256
colorscheme distinguished


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- From Alexander Shukaev on stack overflow (13850914)
" --- These mappings may not be useful to me, but they would force a new vim
" --- student to use vim correctly.
" no arrows in normal
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>
" no arrows in insert
inoremap <Up>    <Nop>
inoremap <Down>  <Nop>
inoremap <Left>  <Nop>
inoremap <Right> <Nop>
" no arrows in visual
vnoremap <Up>    <Nop>
vnoremap <Down>  <Nop>
vnoremap <Left>  <Nop>
vnoremap <Right> <Nop>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- F keys - the F keys should work in all modes
nnoremap <F5> :GundoToggle<CR>
inoremap <F5> <ESC>:GundoToggle<CR>i
vnoremap <F5> <ESC>:GundoToggle<CR>

nnoremap <F6> :TagbarToggle<CR>
inoremap <F6> <ESC>:TagbarToggle<CR>i
vnoremap <F6> <ESC>:TagbarToggle<CR>

nnoremap <F7> :PencilToggle<CR>
inoremap <F7> <ESC>:PencilToggle<CR>i
vnoremap <F7> <ESC>:PencilToggle<CR>

nnoremap <F8> :NERDTreeToggle<CR>
inoremap <F8> <ESC>:NERDTreeToggle<CR>i
vnoremap <F8> <ESC>:NERDTreeToggle<CR>

" nnoremap <F9> <Plug>RStart 
" inoremap <F9> <Plug>RStart
" vnoremap <F9> <Plug>RStart 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- tags and other navigation magic
" --- For nice discussion on ctags and whatnot:
" --- https://andrew.stwrt.ca/posts/vim-ctags/
" Search for tags along directory ancestral tree 
set tags=./tags,tags;$HOME



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- BUFFERS, TABS, WINDOWS, and all that
set hidden
nnoremap <C-h> :bprev<CR>
nnoremap <C-l> :bnext<CR>
let g:buftabline_show=1
let g:buftabline_indicators="on"
let g:buftabline_numbers=2
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- NerdTree
" Close window if only NerdTree is left (borrowed from NerdTree docs)
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open NerdTree if no other file selected
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- UltiSnips
" Snippet commands - for use with ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="horizontal"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- Gundo options
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- YouCompleteMe options
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- Vinarise options
let g:vinarise_enable_auto_detect=1
let g:vinarise_detect_large_file_size=-1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- Pencil options
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init({'wrap': 'soft'})
  autocmd FileType text call pencil#init({'wrap': 'hard'})
  let g:pencil#wrapModeDefault = 'soft'
augroup END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- Goyo options
function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  set nonumber
  "set scrolloff=999
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
  set number
  "set scrolloff=5
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
" vim-r-plugin options
let vimrplugin_assign = 0
let vimrplugin_applescript = 0
let vimrplugin_screenplugin = 0
" send selection to R
vmap <C-CR> <Plug>RDSendSelection 
" send line to R
nmap <C-CR> <Plug>RDSendLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP options
" HELP: :help ctrlp-commands and :help ctrlp-extensions
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_map = '<c-p>'
" use gitignore - https://github.com/ctrlpvim/ctrlp.vim
set wildignore+=*.o,*.so,*.gch,*.out,*.gz,*.bz2
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" --- GitGutter options
" Notes:
" stage the hunk with <Leader>hs or
" undo it with <Leader>hu.
" ---
" Number of changes to track (for performance reasons) default=500
let g:gitgutter_max_signs = 500
" next hunk (default=]c)
" nmap ]c <Plug>GitGutterNextHunk  
" prev hunk (default=]c)
" nmap [c <Plug>GitGutterPrevHunk
" stage a hunk (default=<Leader>hs)
nmap <Leader>hs <Plug>GitGutterStageHunk
" undo a hunk (default=<Leader>hu)
nmap <Leader>hu <Plug>GitGutterUndoHunk
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- tagbar
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- Dealing with particular file types
autocmd BufNewFile,BufRead *.csv,*.tsv,*.tab call TabularSettings()
autocmd BufNewFile,BufRead *.R call RSettings()
autocmd BufNewFile,BufRead *.Rnw,*.html call TwoStop()
autocmd BufNewFile,BufRead *.tex call LatexSettings()
autocmd FileType text call TextSettings()
autocmd FileType markdown call MarkdownSettings()
autocmd FileType py call PythonSetting()

function! TabularSettings()
    setlocal nowrap
endfunction

function! LatexSettings()
    setlocal syn=tex
    setlocal ft=tex
    call TwoStop()
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
    setlocal nonumber
endfunction

function! TextSettings()
    setlocal nospell
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
