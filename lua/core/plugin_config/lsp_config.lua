local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

-- Set up Mason
mason.setup()

-- Ensure these LSPs are installed
mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",
	-- Lua server is recommended for easier setup of the configuration
    -- Add the rest of your preferred servers here
  },
})

-- DEPRECATED AFTER MASON 2.0.0 release. See https://github.com/mason-org/mason-lspconfig.nvim/releases/tag/v2.0.0
-- Setup each installed LSP
--mason_lspconfig.setup_handlers {
--  function(server_name)
--    lspconfig[server_name].setup({})
--  end,
--}

-- Replaced by the vim.lsp.config() API
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {
          'vim',
          'require',
        },
      },
    },
  },
})
