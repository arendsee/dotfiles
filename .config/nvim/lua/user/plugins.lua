local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("Failed to load packer")
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)

	use({ "wbthomason/packer.nvim"})
	use({ "nvim-lua/plenary.nvim"})

    -- my personal stuffs
    -- use({'madox2/vim-ai'})
    use({'Lokaltog/vim-distinguished'})
    use({'Shougo/vinarise'})
    -- use({'SirVer/ultisnips'})
    use({'ap/vim-buftabline'})
    use({'easymotion/vim-easymotion'})
    use({'foosoft/vim-argwrap'})
    use({'junegunn/vim-easy-align'})
    use({'majutsushi/tagbar'})
    use({'mbbill/undotree'})
    use({'mhinz/vim-hugefile'})
    use({'mhinz/vim-startify'})
    use({'preservim/nerdcommenter'})
    use({'reedes/vim-pencil'})
    use({'ryanoasis/vim-devicons'})
    use({'terryma/vim-expand-region'})
    use({'christoomey/vim-tmux-navigator'})
    use({'habamax/vim-asciidoctor'})

	-- cmp plugins
	-- use({"hrsh7th/nvim-cmp"}) -- The completion plugin
	-- use({"hrsh7th/cmp-buffer"}) -- buffer completions
	-- use({"hrsh7th/cmp-path"}) -- path completions
	-- use({"saadparwaiz1/cmp_luasnip"}) -- snippet completions
	-- use({"hrsh7th/cmp-nvim-lsp"})
	-- use({"hrsh7th/cmp-nvim-lua"})

	-- snippets
	-- use({"L3MON4D3/LuaSnip"}) --snippet engine
	-- use({"rafamadriz/friendly-snippets"}) -- a bunch of snippets to use -- and some are VERY annoying, I'll make my own Goddamn snippets

    -- -- LSP
    -- use({"williamboman/mason.nvim"}) -- simple to use language server installer
    -- use({'williamboman/mason-lspconfig.nvim'})
    -- use({"neovim/nvim-lspconfig"}) -- enable LSP

	use({ "nvim-telescope/telescope.nvim"})
	-- use({ "lewis6991/gitsigns.nvim"})
    use({'airblade/vim-gitgutter'})
    use({'tpope/vim-fugitive'})

    use({'simrat39/rust-tools.nvim'})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
