local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", " ", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-w>", ":bd<CR>", opts)

keymap("n", "<CR>", ":noh<CR>", opts)

keymap("", "<F8>", ":Lex 30<CR>", opts)

keymap("n", "<localleader>hn", ":Gitsigns next_hunk<CR>", opts)

keymap("n", "<localleader>a", ":ArgWrap<CR>", opts)

-- Wrap paragraph. Here the `gq` is the magic piece, the autoformatting
-- behavior is dependent on the `fo` setting. See `fo-table` in the docs.
keymap("n", "<localleader>w", "ma{V}gq'a$", opts)
