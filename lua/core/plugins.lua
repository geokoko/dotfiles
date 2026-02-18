local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1',
		'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- LSP Management
	use { "mason-org/mason.nvim" }         		-- Mason for managing LSPs
	use { "mason-org/mason-lspconfig.nvim" } 	-- Bridge between Mason & LSP
	use { "neovim/nvim-lspconfig" }           	-- LSP configuration

	-- Plugins
	use 'tpope/vim-surround'                      	-- Surrounding text manipulation
	use 'nvim-tree/nvim-tree.lua'                   -- File explorer
	use 'tpope/vim-commentary'                      -- Commenting
	use 'rafi/awesome-vim-colorschemes'            	-- Colorschemes
	use 'AlexvZyl/nordic.nvim'						-- nordic.nvim
	use 'lifepillar/pgsql.vim'                      -- PostgreSQL support
	use 'ap/vim-css-color'                          -- CSS color preview
	use 'nvim-tree/nvim-web-devicons'               -- Developer icons
	use 'tc50cal/vim-terminal'                      -- Terminal support
	use 'preservim/tagbar'                          -- Tagbar for code navigation
	use 'jiangmiao/auto-pairs'                      -- Auto-pair brackets/quotes
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }  -- Tree-sitter
	use 'Xuyuanp/nerdtree-git-plugin'               -- NERDTree Git integration
	use 'nvim-lualine/lualine.nvim'					-- Status bar
	use 'lewis6991/gitsigns.nvim'                   -- Git signs
	use 'romgrk/barbar.nvim'						-- Tabline for neovim
	use 'tiagovla/tokyodark.nvim'					-- Tokyodark neovim colorscheme
	use 'github/copilot.vim'						-- Github Copilot
	use { 'iamcco/markdown-preview.nvim', run = 'cd app && npm install' }	-- Markdown preview
	use 'nvim-telescope/telescope.nvim'				-- Telescope
	use 'nvim-lua/plenary.nvim'						-- Plenary (dependency for telescope)
	use { 'akinsho/toggleterm.nvim',
		tag = '*',
		config = function()
			require("toggleterm").setup{
				size = 20,
				open_mapping = [[<C-\>]],
				shade_terminals = true,
				direction = 'float',
				float_opts = {
					border = 'curved',
				},
			}
		end
	}												-- Toggleable terminal

	if packer_bootstrap then
		require('packer').sync()
	end
end)
