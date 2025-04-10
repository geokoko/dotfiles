require("nvim-tree").setup({
	sync_root_with_cwd = true,  			-- Keeps tree in sync with current working directory
	respect_buf_cwd = true,     			-- Automatically changes cwd when navigating files
	view = {
		width = 30,
		side = "left",
		preserve_window_proportions = true, -- Prevents tree from resizing when switching tabs
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,  				-- Auto-adjusts tree when opening a file
	},
	actions = {
		open_file = {						
			resize_window = true,   		-- Resize tree properly
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
	filters = {
		dotfiles = false,					-- Show dotfiles
	},
	git = {
		enable = true,						-- Enable git integration
		ignore = false,						-- Show ignored files
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

local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', opts)  -- Toggle file tree
vim.keymap.set('n', '<C-f>', ':NvimTreeFindFile<CR>', opts) -- Focus on the current file

