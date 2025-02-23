require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,                           -- Enable Tree-sitter highlighting
		additional_vim_regex_highlighting = false, -- Disable redundant Vim highlighting
	},
	indent = {
		enable = true,
	},
}

