" Vim syntax file
" Language: Scope
" -----------------------------------------------------------------------------
" INSTALLATION
" Run the following in your UNIX terminal
" $ mkdir -p ~/.vim/syntax/
" $ mkdir -p ~/.vim/ftdetect/
" $ cp scope.vim ~/.vim/syntax/
" $ echo 'au BufRead,BufNewFile *.scope set filetype=scope' > ~/.vim/ftdetect/scope.vim

if exists("b:current_syntax")
  finish
endif

syn match error '[^ \t\n]\+'

" setting operators
syn match operator '+'
syn match operator '='
syn match operator '{'
syn match operator '}'

syn match dot contained '\.'

syn match variable '[a-zA-Z]'
syn match variable '[a-zA-Z][a-z.A-Z]\+[a-zA-Z]' contains=dot
syn match integer '0\|[1-9][0-9]*'

syn keyword keywords scope
syn keyword keywords say

" define todo highlighting
syn keyword tag contained TODO NOTE

" define comments
syn match comment '#.*$' contains=tag

let b:current_syntax = "scope"
hi def link keywords  Keyword 
hi def link operator  Operator
hi def link comment   Comment
hi def link error     Error
hi def link integer   Constant
hi def link dot       Operator
