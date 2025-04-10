require('soil').setup({
	puml_jar = "~/plantuml/plantuml.jar", -- where your plantuml.jar is
  	render_on_write = true, -- Automatically render on save
	output_directory = ".", -- Output directory for generated images
})

-- Filetype association
vim.cmd [[autocmd BufRead,BufNewFile *.puml set filetype=plantuml]]
