" Vim syntax file
" Language: toyloc
" Maintainer: Zebulun Arendsee
" -----------------------------------------------------------------------------
" INSTALLATION
" Run the following in your UNIX terminal
" $ mkdir -p ~/.vim/syntax/
" $ mkdir -p ~/.vim/ftdetect/
" $ cp toyloc.vim ~/.vim/syntax/
" $ echo 'au BufRead,BufNewFile *.toyloc set filetype=toyloc' > ~/.vim/ftdetect/toyloc.vim

if exists("b:current_syntax")
  finish
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global syntax - shared between all sections

" everything is an error by default 
syn match DEFAULT_ERROR '[^ \n\t]\+'
syn match DEFAULT_ERROR ' \+$'

" comments
syn match comment  '#.*'

" primitives
syn region string start=/"/ end=/"/
syn match variable /[a-zA-Z_][a-zA-Z0-9_]*/
syn match number '\h\@<!-\?\(\d*\.\d\+\|\d\+\)\h\@!'

" reserved operators
syn match operator /\./
syn match operator /=/
syn match operator /[()]/

" reserved keywords
syn keyword keywords path 

let b:current_syntax = "toyloc"

hi def link comment  Comment
hi def link string   String
hi def link number   Number
hi def link operator Operator
hi def link keywords Keyword
hi def link DEFAULT_ERROR Error
