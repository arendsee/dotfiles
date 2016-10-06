set nocompatible  " why ???
filetype off      " needs to be off (TODO: why exactly?)

" Reset any autocmd (why ?)
autocmd!

let leader = "\\"
let maplocalleader = " "

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEGIN VUNDLE
" :PlugInstall - to install plugins
" :PlugUpdate  - to update
" :PlugSearch  - list all plugins in vim script
" :PlugClean   - remove plugins not mentioned below
call plug#begin('~/.vim/plugged')

" snippet engine | snippets use by ultisnips engine
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'VundleVim/Vundle.vim'           " Vundle
Plug 'reedes/vim-pencil'              " allows autowrapping for writing
Plug 'junegunn/goyo.vim'              " zen mode
Plug 'vim-scripts/Align'              " align based on a character
Plug 'alx741/vinfo'                   " Read info pages painlessly
Plug 'christoomey/vim-tmux-navigator' " unify tmux and vim window switching
Plug 'junegunn/vim-easy-align'        " align based on a character
Plug 'easymotion/vim-easymotion'      " super fast jellyfish
Plug 'terryma/vim-expand-region'      " autoexpand selections

call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set backspace=indent,eol,start
set clipboard^=autoselect
set noswapfile
set nonumber
set noshowmode
set noshowcmd
set syntax=automatic

filetype plugin on
syntax on
set t_Co=256
colorscheme distinguished

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global (and controversial) key mapping
noremap ; :
noremap : ;
" wrap paragraph
nnoremap <localleader>w ma{V}gq'a$
" search for selected text
vnoremap // y/<C-R>"<CR>
" make escape cancel highlighting
" nnoremap <ESC> <ESC>:noh<CR><ESC>
nnoremap <CR> :noh<CR>
" One hand navigation
noremap <Down>  <PageDown>
noremap <Up>    <PageUp>
noremap <Left>  :bprev<CR>
noremap <Right> :bnext<CR>
" Copy and paste from X-clipboard
" requires +X11 compile option
nnoremap <localleader>p "+p
nnoremap <localleader>P "+P
nnoremap <localleader>d "+dd
nnoremap <localleader>y "+yy
vnoremap <localleader>y "+y
vnoremap <localleader>d "+d
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- easy motion
" Leader
map <localleader><localleader> <Plug>(easymotion-prefix)
nmap s <Plug>(easymotion-overwin-f2)
" JK motions: Line motions
map <localleader>j <Plug>(easymotion-j)
map <localleader>k <Plug>(easymotion-k)
let g:EasyMotion_keys='asdghklqwertyuiopzxcvbnmfj;'
let g:EasyMotion_do_shade=1
let g:EasyMotion_smartcase=1
let g:EasyMotion_smartsign=0
let g:EasyMotion_use_migemo=0
let g:EasyMotion_use_upper=0
let g:EasyMotion_enter_jump_first=1
let g:EasyMotion_space_jump_first=0
let g:EasyMotion_inc_highlight=1
let g:EasyMotion_add_search_history=0
let g:EasyMotion_off_screen_search = 0
let g:EasyMotion_disable_two_key_combo=0
let g:EasyMotion_verbose = 0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- vim-expand-region
map ,              <Plug>(expand_region_expand)
map <localleader>, <Plug>(expand_region_shrink)
let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :0,
      \ 'i''' :0,
      \ 'i]'  :1,
      \ 'a]'  :1,
      \ 'ib'  :1,
      \ 'ab'  :1,
      \ 'iB'  :1,
      \ 'aB'  :1,
      \ 'il'  :0,
      \ 'ip'  :0,
      \ 'ie'  :0,
      \ }
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
