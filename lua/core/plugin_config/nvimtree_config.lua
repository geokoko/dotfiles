local api = require("nvim-tree.api")

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },

})

-- Keybindings for NvimTree
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<C-n>', ':NvimTreeFindFile<CR>', opts)  -- Find the current file in tree
vim.keymap.set('n', '<C-f>', ':NvimTreeFocus<CR>', opts)     -- Focus on the tree
vim.keymap.set('n', '<C-t>', ':NvimTreeToggle<CR>', opts)    -- Toggle the file tree

