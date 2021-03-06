" Vim syntax file 
" Language: SPARQL 
" Creator: Jeroen Pulles <jeroen.pulles@redslider.net>

" This is adapted with very minor modifictions from https://www.vim.org/scripts/script.php?script_id=1755

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" A.3 Keywords are matched in a case-insensitive manner. (only keywords)
syntax case ignore
syntax keyword rqKeyword BASE PREFIX SELECT DISTINCT CONSTRUCT DESCRIBE ASK FROM NAMED WHERE ORDER BY ASC DESC LIMIT OFFSET OPTIONAL GRAPH FILTER UNION MINUS DISTINCT GROUP BY HAVING NOT EXISTS SERVICE AS BINDINGS
syntax keyword rqBuiltinCall STR LANG DATATYPE BOUND isIRI isURI isBLANK isLITERAL ROUND BIND
syntax keyword rqBuiltinAggregate COUNT MIN MAX SUM AVG GROUP_CONCAT SAMPLE 

syntax keyword rqStringFunction STRLEN SUBSTR UCASE LCASE STRSTARTS STRENDS STRBEFORE STRAFTER ENCODE_FOR_URI CONCAT LANGMATCHES REGEX REPLACE
syntax match rqContains 'CONTAINS' " since 'contains' conflicts with the vim keyword

syntax keyword rqNumericFunction ABS ROUND CEIL FLOOR RAND
syntax keyword rqTimeFunction NOW YEAR MONTH DAY HOURS MINUTES SECONDS TIMEZONE TZ


syntax case match
" case sensitive: 
syntax keyword rqRdfType a
syntax keyword rqBoolean true false 
syntax keyword Todo TODO FIXME XXX 
" A.4 Comments 
syntax match rqComment /\#.*$/ contains=Todo,rqCodepointEscape 

" A.5 & A.6 Escape sequences  
syntax match rqCodepointEscape /\(\\U\x\{8\}\|\\u\x\{4\}\)/ contained contains=NONE
syntax match rqStringEscape +\\[tnrbf\"']\++ contained contains=NONE

" Strings
" [63], [78], [79], [80], [81]
syntax match rqStringSingle +'\([^\u0027\u005C\u000A\u000D]\|\\[tnrbf\\"']\+\|\\U\x\{8\}\|\\u\x\{4\}\)*'+ contains=rqStringEscape,rqCodepointEscape,@Spell 
syntax match rqStringDouble +"\([^\u0022\u005C\u000A\u000D]\|\\[tnrbf\\"']\+\|\\U\x\{8\}\|\\u\x\{4\}\)*"+ contains=rqStringEscape,rqCodepointEscape,@Spell 
syntax region rqStringLongSingle start=+'''+ end=+'''+ contains=rqStringEscape,rqCodepointEscape,@Spell 
syntax region rqStringLongDouble start=+"""+ end=+"""+ contains=rqStringEscape,rqCodepointEscape,@Spell 
syntax cluster rqString contains=rqStringSingle,rqStringDouble,rqStringLongSingle

" Names 
" [69] Qname
syntax match rqQnamePrefix /\(\w\|\\U\x\{8\}\|\\u\x\{4\}\)\+:/he=e-1 contains=rqCodepointEscape 
" [67] Q_IRI_REF 
syntax match rqQIRIREF /<[^<>'{}|^`\u00-\u20]*>/hs=s+1,he=e-1 contains=rqCodepointEscape 
" [71], [72], [88-90] Variables 
" (JPU: High code points crash my vim, too many character classes SEGV my vim
"  I'll just keep it simple for now: recognize word-class characters plus
"  escapes: )
syntax match rqVar /[?$]\{1\}\(\w\|\\U\x\{8\}\|\\u\x\{4\}\)\+/ contains=rqCodepointEscape 



highlight link rqKeyword Keyword 
highlight link rqBuiltinAggregate Keyword
highlight link rqBuiltinCall Keyword
highlight link rqStringFunction Keyword
highlight link rqContains Keyword
highlight link rqNumericFunction Keyword
highlight link rqTimeFunction Keyword
highlight link rqVar Identifier 
highlight link rqStringSingle String 
highlight link rqStringLongSingle String 
highlight link rqStringDouble String 
highlight link rqStringLongDouble String 
highlight link rqComment Comment
highlight link rqRdfType Constant 
highlight link rqQIRIREF Constant
highlight link rqBoolean Constant
highlight link rqQnamePrefix Macro
highlight link rqCodepointEscape SpecialChar 
highlight link rqStringEscape SpecialChar 


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_sparql_syn_inits")
  if version < 508
    let did_sparql_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

"  HiLink mysqlKeyword		 Statement

  delcommand HiLink
endif

let b:current_syntax = "sparql"
