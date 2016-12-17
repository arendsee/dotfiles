" Vim syntax file
" Language: Prolog
" Maintainer: Zebulun Arendsee
" -----------------------------------------------------------------------------
" INSTALLATION
" Run the following in your UNIX terminal
" $ mkdir -p ~/.vim/syntax/
" $ mkdir -p ~/.vim/ftdetect/
" $ cp pro.vim ~/.vim/syntax/
" $ echo 'au BufRead,BufNewFile *.pro set filetype=pro' > ~/.vim/ftdetect/pro.vim

if exists("b:current_syntax")
  finish
endif

" setting operators
syn match operator ':-'
syn match operator '?-'
syn match operator '\.'

syn match logical 'true|false'

" define todo highlighting
syn keyword tag contained TODO NOTE

" define comments
syn match comment '%.*$' contains=tag

let b:current_syntax = "pro"
hi def link logical     Constant
hi def link operator    Operator
hi def link comment     Comment
