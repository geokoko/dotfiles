require('mason-lspconfig').setup({
    ensure_installed = { "lua_ls", "clangd" },  
    automatic_installation = true,
})


local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

require('mason-lspconfig').setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({})
    end
})
