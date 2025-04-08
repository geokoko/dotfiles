require('soil').setup({
	plantuml_jar_path = "~/plantuml/plantuml.jar", -- where your plantuml.jar is
  	render_on_write = true, -- Automatically render on save
})

-- Filetype association
vim.cmd [[autocmd BufRead,BufNewFile *.puml set filetype=plantuml]]
