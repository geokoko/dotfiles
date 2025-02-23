local opts = { noremap = true, silent = true }

-- Tagbar Mapping
vim.keymap.set('n', '<F8>', ':TagbarToggle<CR>', opts)

-- Tab Navigation
vim.keymap.set('n', '<A-Right>', ':tabnext<CR>', opts)
vim.keymap.set('n', '<A-Left>', ':tabprevious<CR>', opts)
