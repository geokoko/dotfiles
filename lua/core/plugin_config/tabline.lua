-- barbar.nvim plugin config
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-Left>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-Right>', '<Cmd>BufferNext<CR>', opts)

-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)

-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)

-- Goto pinned/unpinned buffer
--                 :BufferGotoPinned
--                 :BufferGotoUnpinned

-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)

-- Wipeout buffer
--                 :BufferWipeout

-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight

-- Magic buffer-picking mode
map('n', '<C-p>',   '<Cmd>BufferPick<CR>', opts)
map('n', '<C-s-p>', '<Cmd>BufferPickDelete<CR>', opts)

-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

require('barbar').setup({
     highlights = {
    -- currently active buffer
    buffer_current = { bg = "NONE" },
    buffer_current_index = { bg = "NONE" },
    buffer_current_mod = { bg = "NONE" },
    buffer_current_sign = { bg = "NONE" },
    buffer_current_target = { bg = "NONE" },

    -- inactive/visible buffers
    buffer_visible = { bg = "NONE" },
    buffer_visible_index = { bg = "NONE" },
    buffer_visible_mod = { bg = "NONE" },
    buffer_visible_sign = { bg = "NONE" },
    buffer_visible_target = { bg = "NONE" },

    buffer_inactive = { bg = "NONE" },
    buffer_inactive_index = { bg = "NONE" },
    buffer_inactive_mod = { bg = "NONE" },
    buffer_inactive_sign = { bg = "NONE" },
    buffer_inactive_target = { bg = "NONE" },

    -- if you use icons, also clear their bg
    buffer_current_icon   = { bg = "NONE" },
    buffer_visible_icon   = { bg = "NONE" },
    buffer_inactive_icon  = { bg = "NONE" },

    -- fill area at the right of the tabs
    tabline_fill = { bg = "NONE" },
  },
})

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
