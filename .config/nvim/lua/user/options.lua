local options = {
  backup = false,                          -- creates a backup file
  -- clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                         -- always show tabs
  smartcase = true,                        -- smart case
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  -- termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 100,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = false,                  -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                            -- display lines as one long line
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
  textwidth = 80,
  formatoptions = "crqpn",                -- * t  - format textual paragraphs using textwidth (VERY annoying)
                                          -- * cr - auto-wrap comments using textwidth and insert comment leaders
                                          -- * q  - allow manual formatting with 'gq'
                                          -- * p  - don't break on weird periods
                                          -- * n  - recognize numbered lists
                                          -- * a  - automatic formatting
  -- keep the indentation from the prior line (generally nice)
  autoindent = true,
  -- smart indenting is specific to C-like programs, it will mess up wrapping of
  -- text by indenting after the word "for" or "if".
  smartindent = false, }

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end


vim.cmd([[

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
" --- BUFFERS, TABS, WINDOWS, and all that
nnoremap <C-i> :bprev<CR>
nnoremap <C-o> :bnext<CR>
let g:buftabline_show=1
let g:buftabline_indicators="on"
let g:buftabline_numbers=2
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


" ---------------------------------- M A G I C --------------------------------
" =============================================================================

" Vim jump to the last position when reopening a file [1]
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
]]
)
