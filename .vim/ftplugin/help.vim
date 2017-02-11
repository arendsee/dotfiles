" adapted from http://vim.wikia.com/wiki/Learn_to_use_help

" enter link
nnoremap <buffer> f <C-]>:noh<CR>

" go back
nnoremap <buffer> F <C-T>

" find next/prev option
nnoremap <buffer> o /'\l\{2,\}'<CR>:noh<CR>
nnoremap <buffer> O ?'\l\{2,\}'<CR>:noh<CR>

" quit
nnoremap <buffer> q :q<CR>

" find next/prev subject
nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>:noh<CR>
nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>:noh<CR>
