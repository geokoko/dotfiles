require'nvim-treesitter.configs'.setup {
	ensure_installed = {
		"c", "cpp", "python", "ocaml", "javascript", "typescript", 
		"html", "css", "rust", "go", "lua",
		"verilog", "json", "yaml", "toml", "markdown", "vim", "bash",
		"dockerfile", "gitignore", "sql"
	},
	highlight = {
		enable = true,                           -- Enable Tree-sitter highlighting
		additional_vim_regex_highlighting = false, -- Disable redundant Vim highlighting
	},
	indent = {
		enable = true,
	},
	autotag = {
		enable = true,
	}
}

