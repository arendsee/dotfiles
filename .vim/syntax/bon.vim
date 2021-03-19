" Vim syntax file
" Language: bondi
" Maintainer: Zebulun Arendsee
" -----------------------------------------------------------------------------
" INSTALLATION
" Run the following in your UNIX terminal
" $ mkdir -p ~/.vim/syntax/
" $ mkdir -p ~/.vim/ftdetect/
" $ cp bon.vim ~/.vim/syntax/
" $ echo 'au BufRead,BufNewFile *.bon set filetype=bon' > ~/.vim/ftdetect/bon.vim



" =============================================================================
"                             P R E A M B L E                                  
" -----------------------------------------------------------------------------
if exists("b:current_syntax")
  finish
endif

let b:current_syntax = "bon"



" =============================================================================
"                             K E Y W O R D S                                  
" -----------------------------------------------------------------------------


syn keyword statement let
syn keyword statement in
syn keyword statement if
syn keyword statement then
syn keyword statement else

syn keyword reserved lin
syn keyword reserved cpc
syn keyword reserved ret
syn keyword reserved of
syn keyword reserved and
syn keyword reserved fun
syn keyword reserved extends

syn keyword constructor class
syn keyword constructor datatype

" -----------------------------------------------------------------------------
hi def link reserved Keyword
hi def link constructor Type
hi def link statement Statement



" =============================================================================
"                           P R I M A T I V E S                                
" -----------------------------------------------------------------------------
syn region s_string start=/"/ end=/"/
syn region s_execute start=/`/ end=/`/
syn region s_execute start=/\[[a-zA-Z0-9]*|/ end=/|\]/
syn match s_num '\([a-zA-Z_]\)\@<!\<[0-9]\+\>\([a-zA-Z_]\)\@!'
syn match s_dbl '\([a-zA-Z_]\)\@<!\<[0-9]\+\.[0-9]\+\>\([a-zA-Z_]\)\@!'
syn match s_macro '^%[a-zA-Z_]\+'

" syn match s_num '\v(\h)@<!-?(\d*\.\d+|\d+)(\h)\@!'
"                  -------                ------- 
"                  negative look behind   negative look ahead
" -----------------------------------------------------------------------------
hi def link s_num      Number
hi def link s_dbl      Number
hi def link s_string   String
hi def link s_execute  String
hi def link s_macro    Macro

" =============================================================================
"                            O P E R A T O R S                                 
" -----------------------------------------------------------------------------
syn match operator /</
syn match operator />/
syn match operator /\~/
syn match operator /-/
syn match operator /+/
syn match operator /\*/
syn match operator /\\/
syn match operator /\//
syn match operator /\^/
syn match operator /=/
syn match operator /,/
syn match operator /\./
syn match operator /|/
syn match operator /:/
syn match operator /;/
syn match operator /->/

" -----------------------------------------------------------------------------
hi def link operator Operator



" =============================================================================
"                             C O M M E N T S                                  
" -----------------------------------------------------------------------------
" define todo highlighting
syn match s_todo /\(TODO\|NOTE\|FIXME\):/ contained 
syn keyword s_todo XXX contained
syn match s_tag /\(Author\|Email\|Github\|Bugs\|Website\|Maintainer\|Description\):/ contained 

" define comments
" syn match comment '\/\/.*$' contains=tag
" syn region comment start='\/\*' end='\*\/' contains=tag
syn match s_comment '--.*' contains=s_todo,s_tag
syn region s_comment start="(\*" end="\*)" contains=s_todo,s_tag

" =============================================================================
"                               E R R O R S                                    
" -----------------------------------------------------------------------------
syn match s_error '^#'

" -----------------------------------------------------------------------------
hi def link s_comment  Comment
hi def link s_todo     Todo
hi def link s_tag      SpecialComment
hi def link s_error    Error
