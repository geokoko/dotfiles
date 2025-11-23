local opts = { noremap = true, silent = true }

-- Tagbar Mapping
vim.keymap.set('n', '<F8>', ':TagbarToggle<CR>', opts)

-- Tab Navigation
vim.keymap.set('n', '<A-Right>', ':tabnext<CR>', opts)
vim.keymap.set('n', '<A-Left>', ':tabprevious<CR>', opts)

-- LSP Diagnostics
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
