HOME = os.getenv("HOME")

function nmap(key, cmd)
    vim.api.nvim_set_keymap("n", key, cmd, {noremap = true, silent = true})
end

function imap(key, cmd)
    vim.api.nvim_set_keymap("i", key, cmd, {noremap = true, silent = true})
end

function vmap(key, cmd)
    vim.api.nvim_set_keymap("v", key, cmd, {noremap = true, silent = true})
end

function amap(key, cmd)
    nmap(key, cmd)
    imap(key, cmd)
    vmap(key, cmd)
end

function rnmap(key, cmd)
    vim.api.nvim_set_keymap("n", key, cmd, {noremap = false, silent = true})
end

function rimap(key, cmd)
    vim.api.nvim_set_keymap("i", key, cmd, {noremap = false, silent = true})
end

function rvmap(key, cmd)
    vim.api.nvim_set_keymap("v", key, cmd, {noremap = false, silent = true})
end

function ramap(key, cmd)
    rnmap(key, cmd)
    rimap(key, cmd)
    rvmap(key, cmd)
end



vim.opt.ai = true
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.swapfile = false
vim.opt.number = true
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.syntax = "automatic"
vim.opt.wildmode = {"longest", "list"}
vim.opt.history = 10000
vim.opt.scrolloff = 5
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.backspace = {"indent", "eol", "start"}
-- set relativenumber " NOTE: potential performance penalty
vim.opt.lazyredraw = true     -- offsets the penalty of relativenumber
-- tell it to use an undo file
vim.opt.undofile = true
vim.opt.undodir = {HOME .. "/.vimundo", "."}
vim.opt.verbose = 0
vim.g.maplocalleader = " "
vim.opt.filetype.plugin = "on"
vim.opt.syntax = "on"
vim.opt.hidden = true



-- enter removes highlighting
nmap("<CR>", ":noh<CR>") 

-- move between buggers
nmap("<Left>", ":bprev<CR>")
amap("<C-u>", ":bprev<CR>")
nmap("<Right>", ":bnext<CR>")
amap("<C-o>", ":bnext<CR>")

-- close the current buffer
amap("<C-w>", ":bd<CR>")

-- Copy and paste from X-clipboard
-- * requires +X11 compile option
nmap('<localleader>p',  '"+p')
nmap('<localleader>P',  '"+P')
nmap('<localleader>d', '"+dd')
nmap('<localleader>y', '"+yy')
vmap('<localleader>y',  '"+y')
vmap('<localleader>d',  '"+d')

-- open file in a text
nmap("gf", ":vert winc f<cr>")

-- argwrap settings
nmap("<localleader>a", ":ArgWrap<CR>")



-- =============================== BEGIN SECTION ===============================
-- --- PLUGINS
-- -----------------------------------------------------------------------------
-- :PlugInstall - to install plugins
-- :PlugUpdate  - to update
-- :PlugSearch  - list all plugins in vim script
-- :PlugClean   - remove plugins not mentioned below
-- -----------------------------------------------------------------------------

vim.cmd([[
call plug#begin('~/.local/share/nvim/site/pack/plugged')
 Plug 'Lokaltog/vim-distinguished'
 Plug 'Shougo/vinarise'
 Plug 'SirVer/ultisnips'

 Plug 'lewis6991/gitsigns.nvim'

 Plug 'ap/vim-buftabline'
 Plug 'christoomey/vim-tmux-navigator'
 Plug 'ctrlpvim/ctrlp.vim'
 Plug 'easymotion/vim-easymotion'
 Plug 'foosoft/vim-argwrap'
 Plug 'junegunn/vim-easy-align'
 Plug 'majutsushi/tagbar'
 Plug 'mbbill/undotree'
 Plug 'mhinz/vim-hugefile'
 Plug 'mhinz/vim-startify'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'preservim/nerdcommenter'
 Plug 'reedes/vim-pencil'
 Plug 'ryanoasis/vim-devicons'
 Plug 'scrooloose/nerdtree'
 Plug 'terryma/vim-expand-region'
 " neovim specific
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 " need to run ":CocInstall coc-json coc-tsserver" after installation
call plug#end()
]])



vim.cmd([[

" ------------------------------- begin subsection ----------------------------
" --- aesthetic settings
" To turn on 256 bit colors and the awesome distinguished theme, uncomment
" the lines below. Note that 256 bit color may require setting on parameters
" in your kernel, or something.
set t_Co=256
colorscheme distinguished
" -----------------------------------------------------------------------------



" ------------------------------- begin subsection ----------------------------
" --- easy-align settings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" -----------------------------------------------------------------------------



" ------------------------------- begin subsection ----------------------------
" --- NERDCommenter settings
nmap =              <Plug>NERDCommenterNested
vmap =              <Plug>NERDCommenterNested
nmap +              <Plug>NERDCommenterSexy
vmap +              <Plug>NERDCommenterSexy
nmap -              <Plug>NERDCommenterUncomment
vmap -              <Plug>NERDCommenterUncomment
nmap <localleader>= <plug>NERDCommenterAltDelims
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
let g:NERDCustomDelimiters = { 'loc' : { 'left' : '--' }, 'pro' : { 'left' : '%'}, 'scope' : {'left' : '#'}, 'mouse' : {'left' : '#'}, 'toyloc' : {'left' : '#'}, 'haskell' : {'left' : '--'}, 'mop' : {'left' : '--'}, "turtle" : {'left' : '#'}, "sparql" : {'left' : '#'}, "asciidoc" : {'left' : '//'} }
" default alignment to use, one of 'none', 'left', 'start', or 'both'
let NERDDefaultAlign='both'
" -----------------------------------------------------------------------------




" ------------------------------- begin subsection ----------------------------
" --- UltiSnips
" Snippet commands - for use with ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="horizontal"
" -----------------------------------------------------------------------------



" ------------------------------- begin subsection ----------------------------
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
" -----------------------------------------------------------------------------



" ------------------------------- begin subsection ----------------------------
" --- F keys - the F keys should work in all modes
" +++ Reserve F5-F8 for toggling windows (e.g. NerdTree)
nnoremap <F5> :UndotreeToggle<CR>
inoremap <F5> <ESC>:UndotreeToggle<CR>i
vnoremap <F5> <ESC>:UndotreeToggle<CR>
" Open Tagbar window on right
nnoremap <F6> :TagbarToggle<CR>
inoremap <F6> <ESC>:TagbarToggle<CR>i
vnoremap <F6> <ESC>:TagbarToggle<CR>
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
" -----------------------------------------------------------------------------



" ------------------------------- begin subsection ----------------------------
" --- BUFFERS, TABS, WINDOWS, and all that
let g:buftabline_show=1
let g:buftabline_indicators="on"
let g:buftabline_numbers=2
" -----------------------------------------------------------------------------



" ------------------------------- begin subsection ----------------------------
" --- NerdTree
" set default shell - needed for nerdtree-git-plugin
set shell=sh
" Close window if only NerdTree is left (borrowed from NerdTree docs)
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open NerdTree if no other file selected
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" -----------------------------------------------------------------------------



" ------------------------------- begin subsection ----------------------------
" --- CtrlP options
" --- HELP: :help ctrlp-commands and :help ctrlp-extensions
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_regexp = 1
" use gitignore - https://github.com/ctrlpvim/ctrlp.vim
set wildignore+=*.o,*.so,*.gch,*.out,*.gz,*.bz2,*.hi
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
nnoremap <leader>o :CtrlP<cr>
" -----------------------------------------------------------------------------


" ------------------------------- begin subsection ----------------------------
" --- GitGutter options
" stage the hunk with <Leader>hs or
" undo it with <Leader>hu.
" -----------------------------------------------------------------------------
" Number of changes to track (for performance reasons) default=500
let g:gitgutter_max_signs = 5000 " big enough to remember all changes in any
                                 " realistic code file, but not in big data
                                 " files
" stage a hunk (default=<Leader>hs)
nmap <localleader>hs <Plug>(GitGutterStageHunk)
" undo a hunk (default=<Leader>hu)
nmap <localleader>hu <Plug>(GitGutterUndoHunk)
" preview hunk
nmap <localleader>hp <Plug>(GitGutterPreviewHunk) <C-j>
" prev hunk
nmap [c <Plug>(GitGutterPrevHunk)
" next hunk
nmap ]c <Plug>(GitGutterNextHunk)
" -----------------------------------------------------------------------------



" ------------------------------- begin subsection ----------------------------
" --- vim-expand-region
map ,              <Plug>(expand_region_expand)
map <localleader>, <Plug>(expand_region_shrink)
let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :0,
      \ 'i''' :0,
      \ 'is'  :0,
      \ 'as'  :0,
      \ 'i]'  :1,
      \ 'a]'  :1,
      \ 'ib'  :1,
      \ 'ab'  :1,
      \ 'iB'  :1,
      \ 'aB'  :1,
      \ 'il'  :0,
      \ 'ip'  :0,
      \ 'ie'  :0,
      \ }
" -----------------------------------------------------------------------------



" -------------------------- haskell crap 00000000000000000000
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" ================================


" ---------------------------------- M A G I C --------------------------------
" =============================================================================

" Vim jump to the last position when reopening a file [1]
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
]]
)
