let b:current_syntax = ''
unlet b:current_syntax
syn include @Awk syntax/awk.vim

syn region awk start=/awk .*'$/ skip=/\\'/ end=/'/ contains=@Awk
