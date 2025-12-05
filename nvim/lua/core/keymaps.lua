vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Tagbar
map('n', '<F8>', ':TagbarToggle<CR>', opts)

-- Tabs
map('n', '<A-Right>', ':tabnext<CR>', opts)
map('n', '<A-Left>', ':tabprevious<CR>', opts)

-- LSP Diagnostics
map('n', '<leader>e', vim.diagnostic.open_float, opts)
map('n', '[d', vim.diagnostic.goto_prev, opts)
map('n', ']d', vim.diagnostic.goto_next, opts)
map('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Terminal
map('t', '<Esc>', [[<C-\><C-n>]], opts)
map('n', '<leader>tt', '<cmd>ToggleTerm direction=float<CR>', opts)
map('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>', opts)
map('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<CR>', opts)

-- Telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', opts)
