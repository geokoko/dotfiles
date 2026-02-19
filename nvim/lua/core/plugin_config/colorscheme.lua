-- Colors and Appearance (choose your settings here)
vim.opt.background = 'dark'             	-- Dark background
vim.opt.termguicolors = false           	-- to use classic vim colorscheme
vim.cmd('syntax on')                   		-- Enable syntax highlighting
vim.cmd('set t_Co=256')						-- Force 256 color support
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    -- Make the default tabline flat
    vim.cmd([[
      hi! link TabLine      Normal
      hi! link TabLineSel   Normal
      hi! link TabLineFill  Normal
    ]])

    -- barbar highlight groups: link everything to Normal (no bg)
    local groups = {
      "BufferCurrent", "BufferCurrentIndex", "BufferCurrentMod",
      "BufferCurrentSign", "BufferCurrentTarget", "BufferCurrentIcon",

      "BufferVisible", "BufferVisibleIndex", "BufferVisibleMod",
      "BufferVisibleSign", "BufferVisibleTarget", "BufferVisibleIcon",

      "BufferInactive", "BufferInactiveIndex", "BufferInactiveMod",
      "BufferInactiveSign", "BufferInactiveTarget", "BufferInactiveIcon",

      "BufferTabpages", "BufferTabpageFill",
    }

    for _, g in ipairs(groups) do
      vim.cmd('hi! link ' .. g .. ' Normal')
    end
  end,
})
-- Use classic vim colorscheme
vim.cmd('colorscheme vim')
-- Make identifiers white
vim.api.nvim_set_hl(0, "Identifier", { fg = "#ffffff" })

-- make Normal text white too
vim.api.nvim_set_hl(0, "Normal", { fg = "#ffffff" })

