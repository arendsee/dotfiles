set nocompatible  " why ???
filetype off      " needs to be off (TODO: why exactly?)

" Reset any autocmd (why ?)
autocmd!


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEGIN VUNDLE
" :PluginInstall - to install plugins
" :PluginUpdate  - to update
" :PluginSearch  - list all plugins in vim script
" :PluginClean   - remove plugins not mentioned below
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'         " Vundle
Plugin 'ervandew/supertab'            " magic with TAB
Plugin 'screen.vim'                   " something I don't exactly know how to use
Plugin 'tComment'                     " language-aware commenting
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
Plugin 'shinokada/dragvisuals.vim'    " Damian Conway's drag thing
Plugin 'Lokaltog/vim-distinguished'   " Coloscheme
" * requires compilation with --enable-pythoninterp flag set
" ** requires installation of ipython

call vundle#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


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
set history=10000
" tell it to use an undo file
set undofile

" autocmd BufNewFile,BufRead *.tex set syn=tex
" nnoremap <SID>annoying_latex_thing_cj <Plug>IMAP_JumpForward
filetype plugin on
syntax on
colorscheme distinguished
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global (and controversial) key mapping
noremap ; :
noremap : ;
" select a word with spacebar
noremap <space> viw
" press enter to reset highlighting
nnoremap <CR> :noh<CR><CR>
" wrap paragraph
nnoremap <leader>p ma{V}gq'a$
" search for selected text
vnoremap // y/<C-R>"<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- Set color schemes
" To turn on 256 bit colors and the awesome distinguished theme, uncomment
" the lines below. Note that 256 bit color may require setting on parameters
" in your kernel, or something.
set t_Co=256
colorscheme distinguished
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- Dirty hacks for fixing dumb problems
" remove the annoying ESC delay ---
" NOTE: if you are using tmux, you will also need to add the following command
" to your .tmux.conf file:
" set -s escape-time 0
set timeoutlen=200 ttimeoutlen=0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- From Alexander Shukaev on stack overflow (13850914)
" --- These mappings force a new vim student to use vim correctly.
" --- However, I have no reason to use them currently use them
" " no arrows in normal
" noremap <Up>    <Nop>
" noremap <Down>  <Nop>
" noremap <Left>  <Nop>
" noremap <Right> <Nop>
" " no arrows in insert
" inoremap <Up>    <Nop>
" inoremap <Down>  <Nop>
" inoremap <Left>  <Nop>
" inoremap <Right> <Nop>
" " no arrows in visual
" vnoremap <Up>    <Nop>
" vnoremap <Down>  <Nop>
" vnoremap <Left>  <Nop>
" vnoremap <Right> <Nop>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- F keys - the F keys should work in all modes
" +++ Reserve F5-F8 for toggling windows (e.g. NerdTree)
" Open Gundo window on left
nnoremap <F5> :GundoToggle<CR>
inoremap <F5> <ESC>:GundoToggle<CR>i
vnoremap <F5> <ESC>:GundoToggle<CR>
" Open Tagbar window on right
nnoremap <F6> :TagbarToggle<CR>
inoremap <F6> <ESC>:TagbarToggle<CR>i
vnoremap <F6> <ESC>:TagbarToggle<CR>
" Open ConqueGdb window on bottom
nnoremap <F7> :ConqueGdb<CR>
inoremap <F7> <ESC>:ConqueGdb<CR>i
vnoremap <F7> <ESC>:ConqueGdb<CR>
" Open NERDTree window on left
nnoremap <F8> :NERDTreeToggle<CR>
inoremap <F8> <ESC>:NERDTreeToggle<CR>i
vnoremap <F8> <ESC>:NERDTreeToggle<CR>
" +++ Reserve F9-F12 for toggling stats
" Toggle Pencil, and auto text folding
nnoremap <F9> :PencilToggle<CR>
inoremap <F9> <ESC>:PencilToggle<CR>i
vnoremap <F9> <ESC>:PencilToggle<CR>
" Toggle R window and all that
nnoremap <F10> <Plug>RStart 
inoremap <F10> <Plug>RStart
vnoremap <F10> <Plug>RStart 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- tags and other navigation magic
" --- For nice discussion on ctags and whatnot:
" --- https://andrew.stwrt.ca/posts/vim-ctags/
" Search for tags along directory ancestral tree 
set tags=./tags,tags;$HOME
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


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
" --- Dealing with particular file types
autocmd BufNewFile,BufRead *.csv,*.tsv,*.tab,*.gff call TabularSettings()
autocmd BufNewFile,BufRead *.R call RSettings()
autocmd BufNewFile,BufRead *.Rnw,*.html call TwoStop()
autocmd BufNewFile,BufRead *.tex call LatexSettings()
autocmd FileType text call TextSettings()
autocmd FileType markdown call MarkdownSettings()
autocmd FileType py call PythonSetting()
autocmd FileType rnoweb call Rnoweb()

function! TabularSettings()
    setlocal nowrap
    setlocal list
    NoPencil
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

function! Rnoweb()
    setlocal tabstop=2
    setlocal shiftwidth=2
    let g:tex_fold_enabled=1
    setlocal foldmethod=syntax
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -------------------------------------------------------------------
" Plugin Configurations
" -------------------------------------------------------------------
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- NerdTree
" set default shell - needed for nerdtree-git-plugin
set shell=sh
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
" --- vim-r-plugin options
let vimrplugin_assign = 0
let vimrplugin_applescript = 0
let vimrplugin_screenplugin = 0
" send selection to R
vmap <C-CR> <Plug>RDSendSelection 
" send line to R
nmap <C-CR> <Plug>RDSendLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- CtrlP options
" --- HELP: :help ctrlp-commands and :help ctrlp-extensions
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_regexp = 1
" use gitignore - https://github.com/ctrlpvim/ctrlp.vim
set wildignore+=*.o,*.so,*.gch,*.out,*.gz,*.bz2
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_map = '<c-p>'
nnoremap <c-f> :CtrlPTag<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- GitGutter options
" --- Notes:
" --- stage the hunk with <Leader>hs or
" --- undo it with <Leader>hu.
" Number of changes to track (for performance reasons) default=500
let g:gitgutter_max_signs = 100
" stage a hunk (default=<Leader>hs)
nmap <Leader>hs <Plug>GitGutterStageHunk
" undo a hunk (default=<Leader>hu)
nmap <Leader>hu <Plug>GitGutterUndoHunk
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- tagbar
let g:tagbar_compact=1
let g:tagbar_indent=1
let g:tagbar_type_r = {'ctagstype':'r', 'kinds':['f:function']}
let g:tagbar_type_rnoweb = {
  \   'ctagstype':'rnoweb',
  \   'kinds' : [
  \       's:sections',
  \       'f:function',
  \       'c:chunk',
  \   ],
  \   'sro' : '::',
  \   'sort' : 0
  \ }
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- statusline
set statusline=%<%f\ %h%m%r%=%-14.(%b,%l,%c%V%)\ %P
" --- ConqueGDB
let g:ConqueGdb_SaveHistory = 0
let g:ConqueTerm_Color = 1
" Needed to take commands from outside GDB shell
let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_InsertOnEnter = 1
let g:ConqueTerm_TERM = 'xterm'
" open GDB window on left, source on right
let g:ConqueGdb_SrcSplit = 'right'
" set keybindings
let g:ConqueGdb_Leader = ','
let g:ConqueGdb_Run = g:ConqueGdb_Leader . 'r'
let g:ConqueGdb_Continue = g:ConqueGdb_Leader . 'c'
let g:ConqueGdb_Next = g:ConqueGdb_Leader . 'n'
let g:ConqueGdb_Step = g:ConqueGdb_Leader . 's'
let g:ConqueGdb_Print = g:ConqueGdb_Leader . 'p'
let g:ConqueGdb_ToggleBreak = g:ConqueGdb_Leader . 'b'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- Damian Conways Drag vis
vmap  <expr>  <LEFT>   DVB_Drag('left')                     
vmap  <expr>  <RIGHT>  DVB_Drag('right')                    
vmap  <expr>  <DOWN>   DVB_Drag('down')                     
vmap  <expr>  <UP>     DVB_Drag('up')                       
vmap  <expr>  D        DVB_Duplicate()                      

" Remove any introduced trailing whitespace after moving... 
let g:DVB_TrimWS = 1    
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- Goyo options
" Quitting whether Goyo is active or not
" - junegunn: https://github.com/junegunn/goyo.vim/issues/16
function! g:GoyoBefore()
  set noshowmode
  set noshowcmd
  set nonumber
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
