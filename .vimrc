set nocompatible  " why ???
filetype off      " needs to be off (TODO: why exactly?)

" Reset any autocmd (why ?)
autocmd!

let leader = "\\"
let maplocalleader = " "

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEGIN VUNDLE
" :PluginInstall - to install plugins
" :PluginUpdate  - to update
" :PluginSearch  - list all plugins in vim script
" :PluginClean   - remove plugins not mentioned below
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'           " Vundle
Plugin 'ervandew/supertab'              " magic with TAB
Plugin 'screen.vim'                     " something I don't exactly know how to use
Plugin 'scrooloose/nerdcommenter'       " commenting
Plugin 'Vim-R-plugin'                   " R code wrapper
" Plugin 'jalvesaq/R-vim-runtime        "
Plugin 'Python-mode-klen'               " python wrapping etc
" Plugin 'ivanov/vim-ipython'           " **
Plugin 'LaTeX-Box'                      " latex wrapping, keybinding, etc.
Plugin 'SirVer/ultisnips'               " snippet engine
Plugin 'honza/vim-snippets'             " snippets use be ultisnips engine
Plugin 'Gundo'                          " * undo tree, <F5> to open
Plugin 'Shougo/vinarise'                " hex editor
Plugin 'reedes/vim-pencil'              " allows autowrapping for writing
" Plugin 'jpalardy/vim-slime'           " copy and paste into another tmux window
" Plugin 'davidhalter/jedi-vim'         " for autocomplete
Plugin 'junegunn/goyo.vim'              " zen mode
Plugin 'airblade/vim-gitgutter'         " shows changes to git file
Plugin 'majutsushi/tagbar'              " ctag code outline bar
Plugin 'ap/vim-buftabline'              " show buffers
Plugin 'scrooloose/nerdtree'            " filesystem browser
Plugin 'Xuyuanp/nerdtree-git-plugin'    " git flag integration with NerdTree
Plugin 'junegunn/vim-easy-align'        " align based on a character
Plugin 'tpope/vim-fugitive'             " manage git
Plugin 'ctrlpvim/ctrlp.vim'             " CtrlP
Plugin 'shinokada/dragvisuals.vim'      " Damian Conway's drag thing
Plugin 'Lokaltog/vim-distinguished'     " Coloscheme
Plugin 'Chiel92/vim-autoformat'         " code formatting
Plugin 'christoomey/vim-tmux-navigator' " unify tmux and vim window switching
Plugin 'foosoft/vim-argwrap'            " toggle wrapping of functions, arrays, etc
Plugin 'easymotion/vim-easymotion'      " super fast jellyfish
Plugin 'terryma/vim-expand-region'      " autoexpand selections
" Plugin 'kana/vim-textobj-user'          " required for vim-textobj-comment
" Plugin 'glts/vim-textobj-comment'       " allow comment selection with ac and ic
" * requires compilation with --enable-pythoninterp flag set
" ** requires installation of ipython

call vundle#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
set winheight=40
set backspace=indent,eol,start
set ai
" Visual blocks automatically written to system clipboard
set clipboard^=autoselect
set expandtab
set hlsearch
set ignorecase
set incsearch
set noswapfile
set number
set scrolloff=5
set shiftwidth=4
set smartcase
set smarttab
set syntax=automatic
set tabstop=4
set shiftwidth=4
set wildmode=longest,list
set history=10000
" tell it to use an undo file
set undofile
set undodir=$HOME/.vimundo,.
" set this higher to see what vim is or isn't doing
set verbose=0

" autocmd BufNewFile,BufRead *.tex set syn=tex
" nnoremap <SID>annoying_latex_thing_cj <Plug>IMAP_JumpForward
filetype plugin on
syntax on
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global (and controversial) key mapping
noremap ; :
noremap : ;
" wrap paragraph
nnoremap <localleader>p ma{V}gq'a$
" search for selected text
vnoremap // y/<C-R>"<CR>
" make escape cancel highlighting
" nnoremap <ESC> <ESC>:noh<CR><ESC>
nnoremap <CR> :noh<CR>

" One hand navigation
noremap <Down>  5<C-e>
noremap <Up>    5<C-y>
noremap <Left>  <PageUp>
noremap <Right> <PageDown>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- Set color schemes
" To turn on 256 bit colors and the awesome distinguished theme, uncomment
" the lines below. Note that 256 bit color may require setting on parameters
" in your kernel, or something.
set t_Co=256
colorscheme distinguished
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- Dirty hacks for fixing dumb problems
" remove the annoying ESC delay ---
" NOTE: if you are using tmux, you will also need to add the following command
" to your .tmux.conf file:
" set -s escape-time 0
set timeout
set timeoutlen=1000
set ttimeoutlen=1000
set updatetime=100
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- From Alexander Shukaev on stack overflow (13850914)
" --- These mappings force a new vim student to use vim correctly.
" --- However, I have no reason to use them currently use them
" " no arrows in normal
" noremap <Up>    <Nop>
" noremap <Down>  <Nop>
" noremap <Left>  <Nop>
" noremap <Right> <Nop>
" " no arrows in insert
" inoremap <Up>    <Nop>
" inoremap <Down>  <Nop>
" inoremap <Left>  <Nop>
" inoremap <Right> <Nop>
" " no arrows in visual
" vnoremap <Up>    <Nop>
" vnoremap <Down>  <Nop>
" vnoremap <Left>  <Nop>
" vnoremap <Right> <Nop>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- F keys - the F keys should work in all modes
" +++ Reserve F5-F8 for toggling windows (e.g. NerdTree)
" Open Gundo window on left
nnoremap <F5> :GundoToggle<CR>
inoremap <F5> <ESC>:GundoToggle<CR>i
vnoremap <F5> <ESC>:GundoToggle<CR>
" Open Tagbar window on right
nnoremap <F6> :TagbarOpenAutoClose<CR>
inoremap <F6> <ESC>:TagbarOpenAutoCLose<CR>i
vnoremap <F6> <ESC>:TagbarOpenAutoCLose<CR>
" UNUSED
nnoremap <F7> <Nop>
inoremap <F7> <ESC>:<CR>i
vnoremap <F7> <ESC>:<CR>
" Open NERDTree window on left
nnoremap <F8> :NERDTreeToggle<CR>
inoremap <F8> <ESC>:NERDTreeToggle<CR>i
vnoremap <F8> <ESC>:NERDTreeToggle<CR>
" +++ Reserve F9-F12 for toggling stats
" Toggle Pencil, and auto text folding
nnoremap <F9> :PencilToggle<CR>
inoremap <F9> <ESC>:PencilToggle<CR>i
vnoremap <F9> <ESC>:PencilToggle<CR>
" Toggle R window and all that
nnoremap <F10> <Plug>RStart 
inoremap <F10> <Plug>RStart
vnoremap <F10> <Plug>RStart 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- tags and other navigation magic
" --- For nice discussion on ctags and whatnot:
" --- https://andrew.stwrt.ca/posts/vim-ctags/
" Search for tags along directory ancestral tree 
set tags=./tags,tags;$HOME
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- BUFFERS, TABS, WINDOWS, and all that
set hidden
nnoremap <C-i> :bprev<CR>
nnoremap <C-o> :bnext<CR>
let g:buftabline_show=1
let g:buftabline_indicators="on"
let g:buftabline_numbers=2
nmap <localleader>1 <Plug>BufTabLine.Go(1)
nmap <localleader>2 <Plug>BufTabLine.Go(2)
nmap <localleader>3 <Plug>BufTabLine.Go(3)
nmap <localleader>4 <Plug>BufTabLine.Go(4)
nmap <localleader>5 <Plug>BufTabLine.Go(5)
nmap <localleader>6 <Plug>BufTabLine.Go(6)
nmap <localleader>7 <Plug>BufTabLine.Go(7)
nmap <localleader>8 <Plug>BufTabLine.Go(8)
nmap <localleader>9 <Plug>BufTabLine.Go(9)
nmap <localleader>0 <Plug>BufTabLine.Go(10)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- Dealing with particular file types
autocmd BufNewFile,BufRead *.csv,*.tsv,*.tab,*.gff call TabularSettings()
autocmd BufNewFile,BufRead *.R call RSettings()
autocmd BufNewFile,BufRead *.Rnw,*.html call TwoStop()
autocmd BufNewFile,BufRead *.tex call LatexSettings()
autocmd FileType text call TextSettings()
autocmd FileType markdown call MarkdownSettings()
autocmd FileType py call PythonSetting()
autocmd FileType rnoweb call Rnoweb()

function! TabularSettings()
    setlocal nowrap
    setlocal list
    NoPencil
endfunction

function! LatexSettings()
    setlocal syn=tex
    setlocal ft=tex
    call TwoStop()
endfunction

function! RSettings()
    setlocal syn=r
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal expandtab
    map <buffer> <localleader> h RAction("head")
endfunction

function! TwoStop()
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal nonumber
endfunction

function! Rnoweb()
    setlocal tabstop=2
    setlocal shiftwidth=2
    let g:tex_fold_enabled=1
    setlocal foldmethod=syntax
endfunction

function! TextSettings()
    setlocal nospell
    setlocal nonumber
endfunction

function! MarkdownSettings()
    " add row of '=' beneath header
    noremap <localleader>h yypVr=
endfunction

function! PythonSetting()
    let g:slime_target = "tmux"
    let g:slime_paste_file = tempname()
    let g:slime_python_ipython = 1

    " let g:pymode_***
    " jedi-vim does the same thing as ropes, but faster?
    " nmap <buffer> <C-CR> <Plug>SlimeLineSend
    " vmap <buffer> <C-CR> <Plug>SlimeRegionSend
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -------------------------------------------------------------------
" Plugin Configurations
" -------------------------------------------------------------------
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- NerdTree
" set default shell - needed for nerdtree-git-plugin
set shell=sh
" Close window if only NerdTree is left (borrowed from NerdTree docs)
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open NerdTree if no other file selected
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- UltiSnips
" Snippet commands - for use with ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="horizontal"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- Gundo options
" p    - show the whole diff from head to current node
" <cr> - revert
" Set the horizontal width of the Gundo graph (and preview).
let g:gundo_width=45
" Set the vertical height of the Gundo preview.
let g:gundo_preview_height=15
" Force the preview window below current windows instead of below the graph.
let g:gundo_preview_bottom=1
" 0 - open Gundo graph (and preview) left side
" 1 - open Gundo graph (and preview) right side
let g:gundo_right=0
" Set this to 0 to disable the help text in the Gundo graph window.
let g:gundo_help=0
" Set this to 1 to automatically close the Gundo windows when reverting.
let g:gundo_close_on_revert=0
" Set this to 0 to disable automatically rendering preview diffs as you move
" through the undo tree (you can still render a specific diff with r).  This can
" be useful on large files and undo trees to speed up Gundo.
let g:gundo_auto_preview=1
" This is the delay in milliseconds between each change when running 'play to'
" mode. Set this to a higher number for a slower playback or to a lower number
" for a faster playback.
let g:gundo_playback_delay=60
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- YouCompleteMe options
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- Vinarise options
let g:vinarise_enable_auto_detect=1
let g:vinarise_detect_large_file_size=-1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- Pencil options
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init({'wrap': 'soft'})
  autocmd FileType text call pencil#init({'wrap': 'hard'})
  let g:pencil#wrapModeDefault = 'soft'
augroup END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- vim-r-plugin options
let vimrplugin_assign = 0
let vimrplugin_applescript = 0
let vimrplugin_screenplugin = 0
" send selection to R
vmap <C-CR> <Plug>RDSendSelection 
" send line to R
nmap <C-CR> <Plug>RDSendLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- CtrlP options
" --- HELP: :help ctrlp-commands and :help ctrlp-extensions
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_regexp = 1
" use gitignore - https://github.com/ctrlpvim/ctrlp.vim
set wildignore+=*.o,*.so,*.gch,*.out,*.gz,*.bz2,*.hi
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
nnoremap <localleader>o :CtrlP<cr>
nnoremap <localleader>f :CtrlPTag<cr>
" leave a buffer, saving unless it is readonly (this still fails in some cases
" CountBuffers re-adapted from Kyle Strand on superuser
function! CountBuffers ()
    let n = 0 
    for i in range(1, bufnr("$"))
        if buflisted(i) && !empty(bufname(i))
            let n += 1
        endif
    endfor
    return n
endfunction
function! Close_any_buffer ()
    try
        write
    catch /readonly/
    catch /Cannot write/
    catch /No filename/
    finally
        if CountBuffers() == 1
            try
                quit
            catch /E173/
                wqa
            endtry
        else
            bdelete
        endif
    endtry
endfunction
nnoremap <localleader>c :call Close_any_buffer() <cr>
nnoremap <localleader>C :wqa<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- GitGutter options
" --- Notes:
" --- stage the hunk with <Leader>hs or
" --- undo it with <Leader>hu.
" Number of changes to track (for performance reasons) default=500
let g:gitgutter_max_signs = 100
" stage a hunk (default=<Leader>hs)
nmap <localleader>hs <Plug>GitGutterStageHunk
" undo a hunk (default=<Leader>hu)
nmap <localleader>hu <Plug>GitGutterUndoHunk
" preview hunk
nmap <localleader>hp <Plug>GitGutterPreviewHunk <C-j>
" prev hunk
nmap [c <Plug>GitGutterPrevHunk
" next hunk
nmap ]c <Plug>GitGutterNextHunk
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- tagbar
let g:tagbar_type_r = {'ctagstype':'r', 'kinds':['f:function']}
let g:tagbar_type_rnoweb = {
  \   'ctagstype':'rnoweb',
  \   'kinds' : [
  \       's:sections',
  \       'f:function',
  \       'c:chunk',
  \   ],
  \   'sro' : '::',
  \   'sort' : 0
  \ }
nnoremap <localleader>t :TagbarOpenAutoClose<CR>
vnoremap <localleader>t <ESC>:TagbarOpenAutoCLose<CR>

" By default the Tagbar window will be opened on the right-hand side of vim. Set
" this option to open it on the left instead.
let g:tagbar_left=0
" If this is set to a positive value then the Tagbar window will be opened at
" the top or bottom of the Vim window instead of at the side. This can be useful
" for monitors that have been rotated into a vertical position. The value of
" this variable will determine the number of lines to use for the Tagbar window.
" See |g:tagbar_left| for configuring the position of the window.
let g:tagbar_vertical = 0
" Width of the Tagbar window in characters.
let g:tagbar_width = 40
" Width of the Tagbar window when zoomed.
" Possible values are:
"   1: Use the maximum width available.
"   0: Use the width of the longest currently visible tag.
"   >1: Use this width in characters.
let g:tagbar_zoomwidth = 1
" If you set this option the Tagbar window will automatically close when you
" jump to a tag. This implies |g:tagbar_autofocus|. If enabled the "C" flag will
" be shown in the statusline of the Tagbar window. This can also be toggled with
" a key, see |tagbar-keys|.
let g:tagbar_autoclose = 1
" If you set this option the cursor will move to the Tagbar window when it is
" opened.
let g:tagbar_autofocus = 1
" If this option is set the tags are sorted according to their name. If it is
" unset they are sorted according to their order in the source file. Note that
" in the second case Pseudo-tags are always sorted before normal tags of the
" same kind since they don't have a real position in the file.
let g:tagbar_sort = 0
" Setting this option will result in Tagbar omitting the short help at the
" top of the window and the blank lines in between top-level scopes in order to
" save screen real estate.
let g:tagbar_compact = 1
" The number of spaces by which each level is indented. This allows making the
" display more compact or more spacious.
let g:tagbar_indent = 2
" Show the visibility symbols (public/protected/private) to the left of the tag
" name.
let g:tagbar_show_visibility = 0
" Whether line numbers should be shown in the Tagbar window.
" Possible values are:
"   0: Don't show any line numbers.
"   1: Show absolute line numbers.
"   2: Show relative line numbers.
"   -1: Use the global line number settings.
let g:tagbar_show_linenumbers = 0
" Hide tags that are declared non-public. Tags without any visibility
" information will still be shown. If enabled the "v" flag will be shown in the
" statusline of the Tagbar window. This can also be toggled with a key, see
" |tagbar-keys|.
let g:tagbar_hide_nonpublic = 0
" If this option is set to 1 the Vim window will be expanded by the width of the
" Tagbar window if using a GUI version of Vim. Setting it to 2 will also try
" expanding a terminal, but note that this is not supported by all terminals.
" See also |xterm-resize|.
let g:tagbar_expand = 1
" If this option is set then a single- instead of a double-click is used to jump
" to the tag definition.
let g:tagbar_singleclick = 0
" The initial foldlevel for folds in the Tagbar window. Folds with a level
" higher than this number will be closed.
let g:tagbar_foldlevel = 2
" If this variable is set to 1 and the current tag is inside of a closed fold
" then the folds will be opened as much as needed for the tag to be visible so
" it can be highlighted. If it is set to 0 then the folds will only be opened
" when opening the Tagbar window and the current tag is inside a closed fold,
" otherwise the folds won't be opened and the parent tag will be highlighted
" instead. If it is set to 2 then the folds will never be opened automatically.
let g:tagbar_autoshowtag = 1
" The position of the preview window. Valid values are the window splitting
" commands that are described starting from |:vertical|. Set it to an empty
" string to use the options 'splitbelow' and 'splitright'.
" <
" If you want to disable line numbers in the preview window put something like
" this into your vimrc:
" >
"         autocmd BufWinEnter * if &previewwindow | setlocal nonumber | endif
" <
let g:tagbar_previewwin_pos = ""
" If this variable is set to 1 then moving the cursor in the Tagbar window will
" automatically show the current tag in the preview window.
let g:tagbar_autopreview = 0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto-reformatting
nnoremap <C-A> :Autoformat<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- Damian Conways Drag vis
vmap  <expr>  <LEFT>   DVB_Drag('left')                     
vmap  <expr>  <RIGHT>  DVB_Drag('right')                    
vmap  <expr>  <DOWN>   DVB_Drag('down')                     
vmap  <expr>  <UP>     DVB_Drag('up')                       
vmap  <expr>  D        DVB_Duplicate()                      

" Remove any introduced trailing whitespace after moving... 
let g:DVB_TrimWS = 1    
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" easy-align settings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" argwrap settings
nnoremap <localleader>a :ArgWrap<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDCommenter settings
nmap =         <Plug>NERDCommenterNested
vmap =         <Plug>NERDCommenterNested
nmap <leader>+ <Plug>NERDCommenterSexy
vmap <leader>+ <Plug>NERDCommenterSexy
nmap -         <Plug>NERDCommenterUncomment
vmap -         <Plug>NERDCommenterUncomment

"  Allows multipart alternative delimiters when commenting in a visual mode
let NERDAllowAnyVisualDelims=1
" Forces right delimiters to be placed when doing visual-block comments.
let NERDBlockComIgnoreEmpty=1
" Specifies if empty lines should be commented (useful with regions).
let NERDCommentEmptyLines=1
" remove alternative comment delimiters when uncommenting.
let NERDRemoveAltComs=0
" remove the extra spaces when uncommenting
let NERDRemoveExtraSpaces=1
" how the NERD commenter menu will appear (if at all)
let NERDMenuMode=0
" use placeholders when nesting comments
let NERDUsePlaceHolders=1
" add a space after comment
let NERDSpaceDelims=1
" whether trailing whitespace should be deleted when uncommenting
let NERDTrimTrailingWhitespace=1
" use the compact style sexy comments
let NERDCompactSexyComs=0
" nest comments by default
let NERDDefaultNesting=1
" Add or override delimiters for any filetypes
let g:NERDCustomDelimiters = {
 \     'c': {
 \          'left': '//',
 \          'leftAlt': '/*',
 \          'rightAlt': '*/'
 \      },
 \      'cpp': {
 \          'left': '//',
 \          'leftAlt': '/*',
 \          'rightAlt': '*/'
 \     }
 \  }
" default alignment to use, one of 'none', 'left', 'start', or 'both'
let NERDDefaultAlign='both'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- easy motion
" Leader
map <localleader><localleader> <Plug>(easymotion-prefix)

" Disable default mappings
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-overwin-f2)

" JK motions: Line motions
map <localleader>j <Plug>(easymotion-j)
map <localleader>k <Plug>(easymotion-k)

let g:EasyMotion_keys='asdghklqwertyuiopzxcvbnmfj;'
let g:EasyMotion_do_shade=1
let g:EasyMotion_smartcase=1
let g:EasyMotion_smartsign=0
let g:EasyMotion_use_migemo=0
let g:EasyMotion_use_upper=0
let g:EasyMotion_enter_jump_first=1
let g:EasyMotion_space_jump_first=0
let g:EasyMotion_inc_highlight=1
let g:EasyMotion_add_search_history=0
let g:EasyMotion_off_screen_search = 0
let g:EasyMotion_disable_two_key_combo=0
let g:EasyMotion_verbose = 0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" --- vim-expand-region
map ,              <Plug>(expand_region_expand)
map <localleader>, <Plug>(expand_region_shrink)
call expand_region#custom_text_objects({
      \ 'a]' :1,
      \ 'ab' :1,
      \ 'aB' :1,
      \ 'ii' :0,
      \ 'ai' :0,
      \ })
