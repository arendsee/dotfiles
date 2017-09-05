" Vim syntax file
" Language: mop
" Maintainer: Zebulun Arendsee
" -----------------------------------------------------------------------------
" INSTALLATION
" Run the following in your UNIX terminal
" $ mkdir -p ~/.vim/syntax/
" $ mkdir -p ~/.vim/ftdetect/
" $ cp mop.vim ~/.vim/syntax/
" $ echo 'au BufRead,BufNewFile *.mop set filetype=mop' > ~/.vim/ftdetect/mop.vim

if exists("b:current_syntax")
  finish
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global syntax - shared between all sections

" comments
syn match comment  '--.*'

" primitives
syn match variable /[a-zA-Z_][a-zA-Z0-9_]*/
syn match number '\d\+'

" reserved operators
syn match operator /\[/
syn match operator /\]/

" abstractions
syn match function /\\[_a-z]\+/
syn match function /\./

" types
syn match type /:[A-Z][a-zA-Z_]*/
syn match type /:([A-Za-z_ >()-]*)/

" reserved keywords
syn keyword keywords T
syn keyword keywords F

let b:current_syntax = "mop"

hi def link variable Identifier
hi def link comment  Comment
hi def link number   Number
hi def link operator Operator
hi def link keywords Keyword
hi def link function Function 
hi def link type     Type
