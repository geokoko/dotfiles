require("nvim-tree").setup({
  sync_root_with_cwd = true,  -- Keeps tree in sync with current working directory
  respect_buf_cwd = true,     -- Automatically changes cwd when navigating files
  view = {
    width = 30,
    side = "left",
    preserve_window_proportions = true,  -- Prevents tree from resizing when switching tabs
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,  -- Auto-adjusts tree when opening a file
  },
  actions = {
    open_file = {
      quit_on_open = false,   -- Do NOT close tree when opening a file (VS Code behavior)
      resize_window = true,   -- Resize tree properly
    },
  },
  renderer = {
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
      },
    },
    highlight_opened_files = "name",
  },
})

-- Make sure the tree remains open in the new tab with this autocommand
vim.api.nvim_create_autocmd("TabEnter", {
    callback = function()
        local api = require("nvim-tree.api")
        if not api.tree.is_visible() then
            api.tree.open()
        end
    end,
})

-- Ensuring file explorer opens at startup
vim.cmd([[ autocmd VimEnter * NvimTreeOpen ]])

local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', opts)  -- Toggle file tree
vim.keymap.set('n', '<C-f>', ':NvimTreeFindFile<CR>', opts) -- Focus on the current file

