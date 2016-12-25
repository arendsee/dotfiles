" Vim syntax file
" Language: mouse
" Maintainer: Zebulun Arendsee
" -----------------------------------------------------------------------------
" INSTALLATION
" Run the following in your UNIX terminal
" $ mkdir -p ~/.vim/syntax/
" $ mkdir -p ~/.vim/ftdetect/
" $ cp mouse.vim ~/.vim/syntax/
" $ echo 'au BufRead,BufNewFile *.mouse set filetype=mouse' > ~/.vim/ftdetect/mouse.vim

if exists("b:current_syntax")
  finish
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global syntax - shared between all sections

" everything is an error by default 
syn match DEFAULT_ERROR '[^ \n\t]\+' contained
syn match DEFAULT_ERROR ' \+$' contained

syn match comment '#.*'

syn keyword keywords composition 
syn keyword keywords effect

" match all legal variable names (otherwise they default to error)
syn match variable /[a-zA-Z_][a-zA-Z0-9_]*/

" setting operators
syn match operator  /\./
syn match operator    /=/

let b:current_syntax = "mouse"

hi def link keywords Keyword
hi def link operator Operator
hi def link comment  Comment
hi def link DEFAULT_ERROR Error
