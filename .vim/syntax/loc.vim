" Vim syntax file
" Language: loc
" Maintainer: Zebulun Arendsee
" -----------------------------------------------------------------------------
" INSTALLATION
" Run the following in your UNIX terminal
" $ mkdir -p ~/.vim/syntax/
" $ mkdir -p ~/.vim/ftdetect/
" $ cp loc.vim ~/.vim/syntax/
" $ echo 'au BufRead,BufNewFile *.loc set filetype=loc' > ~/.vim/ftdetect/loc.vim

if exists("b:current_syntax")
  finish
endif

let b:current_syntax = ''
unlet b:current_syntax
syn include @R syntax/r.vim

let b:current_syntax = ''
unlet b:current_syntax
syn include @Python syntax/python.vim

let b:current_syntax = ''
unlet b:current_syntax
syn include @Perl syntax/perl.vim

let b:current_syntax = ''
unlet b:current_syntax
syn include @Shell syntax/sh.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global syntax - shared between all sections

" all symbols, trailing space, and non-standard sections (^@.*) are illegal by
" default
syn match DEFAULT_ERROR '@\S*'  contained
syn match DEFAULT_ERROR '\S\+'  contained
syn match DEFAULT_ERROR '\s\+$' contained
" as are all keywords
syn keyword DEFAULT_ERROR id null true false nothing          contained
syn keyword DEFAULT_ERROR filter ternary map                  contained
syn keyword DEFAULT_ERROR readable writable executable record contained
syn keyword DEFAULT_ERROR and or not any all                  contained
syn keyword DEFAULT_ERROR memcache datcache nocache           contained
syn keyword DEFAULT_ERROR TRUE NULL RESET FALSE ?             contained
" syn keyword DEFAULT_ERROR as                             contained

" define todo highlighting
syn keyword s_todo TODO NOTE FIXME XXX contained 
syn match s_tag /\(Author\|Email\|Github\|Bugs\|Website\|Maintainer\|Description\):/ contained 

" define keywords that will be translated into native equivalents
syn keyword s_logical TRUE NULL RESET FALSE contained

" define comments
" syn match comment '\/\/.*$' contains=tag
" syn region comment start='\/\*' end='\*\/' contains=tag
syn match s_comment '#.*' contains=s_todo,s_tag contained

syn match   s_break    '^---\+$' contained
syn match   s_break    ';\+'     contained
syn keyword s_constant __all__   contained

" section headers
syn match s_section '@alias'    contained
syn match s_section '@arg'      contained
syn match s_section '@cache'    contained
syn match s_section '@assert'   contained
syn match s_section '@comment'  contained
syn match s_section '@doc'      contained
syn match s_section '@[0-9]'    contained
syn match s_section '@before'   contained
syn match s_section '@after'    contained
syn match s_section '@export'   contained
syn match s_section '@fail'     contained
syn match s_section '@lang'     contained
syn match s_section '@include'  contained
syn match s_section '@import'   contained
syn match s_section '@ontology' contained
syn match s_section '@path'     contained
syn match s_section '@type'     contained
syn match s_section '@source'   contained


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Section specific syntax

" general default functions
syn keyword s_simple_function id null true false nothing          contained
syn keyword s_simple_function filter ternary map                  contained
syn keyword s_simple_function readable writable executable record contained
syn keyword s_logical_op and or not any all                       contained

syn match s_var  /\h[\w.0-9-]*/                      contained
syn match s_arg  /--\?\w*/                           contained
syn match s_num  '\h\@<!-\?\(\d*\.\d\+\|\d\+\)\h\@!' contained
syn match s_fun  /&\w*/                              contained
syn match s_marg /$\d/                               contained
syn match s_file /[A-Za-z_-]\+\(\/[A-Za-z_-]\+\)*/   contained

" default caching functions
syn keyword s_cache_function memcache datcache nocache contained

syn keyword s_utility undefined contained

" setting operators
syn match s_compose /\_\W\.\_\W\|\_\W\.$/      contained
syn match s_super   /\(\.\*\|\*\.\)/           contained
syn match s_angel   /[><]/                     contained
syn match s_rarrow  /->/                       contained
syn match s_pathsep /\//                       contained
syn match s_couple  /::/                       contained
syn match s_modify  /\(:=\|:-\|:+\)/           contained
syn match s_equal   /=/                        contained
syn match s_switch  /?/                        contained
syn match s_sep     /,/                        contained
syn match s_par     /[()]/                     contained
syn match s_brk     /[\[\]]/                   contained
syn match s_bar     /|/                        contained
syn match s_star    /\_\W\*\_\W\|^\*\_W\|^\*$/ contained

syn match s_positional /`[^`]*`/              contained
syn match s_group      /\*\w\+/               contained
syn match s_refer      /<[A-Za-z0-9_./:-]\+>/ contained

" strings
syn region s_string start=/'/ end=/'/ contained
syn region s_string start=/"/ end=/"/ contained


" define terms used in types
syn keyword s_type Void contained
syn match   s_type /?/  contained

" keywords
syn keyword s_export_keyword as contained

syn keyword s_import_keyword from   contained
syn keyword s_import_keyword as     contained
syn keyword s_import_keyword import contained

" labels
syn match s_varlabel ':\w\+' contained


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set a highlighting paradigm for each section

syn cluster c_subglobal contains=s_comment,s_section,DEFAULT_ERROR
syn cluster c_global    contains=@c_subglobal,s_simple_function,s_var,s_constant,s_logical,s_logical_op

syn cluster c_couple_nl contains=s_couple,s_star
syn cluster c_modify_nl contains=@c_couple_nl,s_modify,s_pathsep
syn cluster c_couple    contains=@c_couple_nl,s_varlabel
syn cluster c_modify    contains=@c_modify_nl,s_varlabel

syn cluster c_hasarg    contains=s_equal,s_num,s_sep,s_brk,s_par,s_fun,s_string
syn cluster c_path      contains=s_compose,s_switch,s_par,s_break,s_super,s_angel,s_positional,s_marg,s_fun,s_group,s_refer
syn cluster c_type      contains=@c_subglobal,@c_couple_nl,s_type,s_rarrow,s_sep,s_par,s_brk,s_var,s_simple_function,s_logical_op

syn region r_top start=/\%^/ end=/@\@=/ skip=/\\@/ contains=s_comment

syn region r_source   start=/@source R$/  end=/@\@=/ skip=/\\@/ contains=s_section,@R
syn region r_source   start=/@source py$/ end=/@\@=/ skip=/\\@/ contains=s_section,@Python
syn region r_source   start=/@source pl$/ end=/@\@=/ skip=/\\@/ contains=s_section,@Perl
syn region r_source   start=/@source sh$/ end=/@\@=/ skip=/\\@/ contains=s_section,@Shell

syn region r_comment  start=/@comment/    end=/@\@=/ skip=/\\@/
                                          
syn region r_alias    start=/@alias/      end=/@\@=/ contains=@c_global,c_equal,@c_hasarg,@c_modify,s_utility
                                          
syn region r_path     start=/@path/       end=/@\@=/ contains=@c_global,@c_couple,@c_hasarg,@c_path
syn region r_assert   start=/@assert/     end=/@\@=/ contains=@c_global,@c_hasarg,@c_modify,@c_path
syn region r_effect   start=/@[0-9]/      end=/@\@=/ contains=@c_global,@c_hasarg,@c_modify,@c_path
syn region r_effect   start=/@before/     end=/@\@=/ contains=@c_global,@c_hasarg,@c_modify,@c_path
syn region r_effect   start=/@after/      end=/@\@=/ contains=@c_global,@c_hasarg,@c_modify,@c_path
syn region r_fail     start=/@fail/       end=/@\@=/ contains=@c_global,@c_hasarg,@c_couple,@c_path
                                          
syn region r_arg      start=/@arg/        end=/@\@=/ contains=@c_global,@c_hasarg,s_positional,s_angel,@c_modify,s_arg
syn region r_cache    start=/@cache/      end=/@\@=/ contains=@c_global,@c_hasarg,s_cache_function,@c_couple
syn region r_doc      start=/@doc/        end=/@\@=/ contains=@c_global,@c_modify,s_string
syn region r_export   start=/@export/     end=/@\@=/ contains=@c_global,s_export_keyword,s_pathsep,s_varlabel
syn region r_lang     start=/@lang/       end=/@\@=/ contains=@c_global,@c_hasarg,@c_modify
syn region r_include  start=/@include/    end=/@\@=/ contains=@c_subglobal,s_file
syn region r_import   start=/@import/     end=/@\@=/ contains=@c_subglobal,s_import_keyword,s_var,s_string
syn region r_ontology start=/@ontology/   end=/@\@=/ contains=@c_type,s_bar,s_sep,s_par,s_brk
syn region r_type     start=/@type/       end=/@\@=/ contains=@c_type,s_star




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Assign colors

let b:current_syntax = "loc"

hi def link s_simple_function Function
hi def link s_cache_function  Function
hi def link s_logical_op      Function

hi def link s_constant Constant
hi def link s_logical  Constant
hi def link s_type     Constant
hi def link s_utility  Constant 

hi def link s_break    Underlined
hi def link s_varlabel Special
hi def link s_section  Label

hi def link s_export_keyword Keyword
hi def link s_import_keyword Keyword

hi def link s_compose Operator
hi def link s_rarrow  Operator
hi def link s_pathsep Operator
hi def link s_couple  Operator
hi def link s_modify  Operator
hi def link s_equal   Operator
hi def link s_depend  Operator
hi def link s_switch  Operator
hi def link s_sep     Operator
hi def link s_super   Operator
hi def link s_angel   Operator
hi def link s_bar     Operator

hi def link s_num      Number
hi def link s_string   String
hi def link s_comment  Comment
hi def link r_comment  Comment
hi def link s_todo     Todo
hi def link s_tag      SpecialComment

hi def link s_positional Identifier
hi def link s_refer      Identifier
hi def link s_group      Identifier
hi def link s_fun        Identifier
hi def link s_marg       Identifier

hi def link DEFAULT_ERROR Error
