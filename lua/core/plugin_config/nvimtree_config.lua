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
  on_attach = function(bufnr)
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    local function open_in_tab_and_close()
		local orig_tab = vim.api.nvim_get_current_tabpage()
		-- Open new tab
		api.node.open.tab()
		-- Go to previous tab and close Nvim Tree
		vim.cmd("NvimTreeOpen")
		vim.cmd("tabprevious")
		vim.cmd("NvimTreeClose")
		vim.cmd("tabnext")
    end

    -- Remap <CR> to use our custom function
    vim.keymap.set("n", "<CR>", open_in_tab_and_close, opts("Open in New Tab and Close Tree"))
  end,
})


-- Keybindings for NvimTree
local opts = { noremap = true, silent = true }

vim.g.nvim_tree_auto_open = 1                                -- Auto open nvim-tree when entering a new tab
vim.keymap.set('n', '<C-n>', ':NvimTreeFindFile<CR>', opts)  -- Find the current file in tree
vim.keymap.set('n', '<C-f>', ':NvimTreeFocus<CR>', opts)     -- Focus on the tree
vim.keymap.set('n', '<C-t>', ':NvimTreeToggle<CR>', opts)    -- Toggle the file tree

