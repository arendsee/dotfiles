runtime syntax/tex.vim

" From https://github.com/vim-scripts/SyntaxRange

" Highlight C block
" @c
" int i;
" @
call SyntaxRange#Include('\v^\@c[^a-z]*', '\v^\@', 'c')

" Highlight C following @<...@> macro insertions
" @c
" @<Functions@>
" int i;
" @
call SyntaxRange#Include('\v\@\>$', '\v^\@', 'c')

" Highlight C in floating C block
" @<....@>=
" int i;
" @
call SyntaxRange#Include('\v^\@\<', '\v^\@', 'c')
