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

Plugin 'VundleVim/Vundle.vim'           " Vundle
Plugin 'reedes/vim-pencil'              " allows autowrapping for writing
Plugin 'junegunn/goyo.vim'              " zen mode
Plugin 'vim-scripts/Align'              " align based on a character
Plugin 'alx741/vinfo'                   " Read info pages painlessly
Plugin 'christoomey/vim-tmux-navigator' " unify tmux and vim window switching
Plugin 'junegunn/vim-easy-align'        " align based on a character

call vundle#end()
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
" navigate Vinfo
nnoremap vn :VinfoNext <CR>
nnoremap vp :VinfoPrev <CR>
nnoremap <Down> <c-e>
nnoremap <Up>   <c-y>
nnoremap <Left> <PageUp>
nnoremap <Right> <PageDown>
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
