return {
	"akinsho/bufferline.nvim",
	event = "BufEnter",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"folke/snacks.nvim",
	},
	keys = {
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Del Current Buffer",
		},
		{
			"<leader>ba",
			function()
				Snacks.bufdelete.all()
			end,
			desc = "Del All Buffer",
		},
		{
			"<leader>bo",
			function()
				Snacks.bufdelete.other()
			end,
			desc = "Del Other Buffer",
		},
		{ "<leader>bc", "<cmd>BufferLinePick<CR>", desc = "Del All Buffer" },
		{ "<leader>bb", "<cmd>e #<cr>", desc = "Switch to Other Buffer" },
		{ "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle Pin" },
		{ "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete Non-Pinned Buffers" },
		{ "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Delete Buffers to the Right" },
		{ "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Delete Buffers to the Left" },
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "[b", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
		{ "]b", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
	},
	opts = {
		options = {
			offsets = {
				{
					filetype = "neo-tree",
					text = "Neo-tree",
					highlight = "Directory",
					text_align = "left",
				},
				{ filetype = "snacks_layout_box" },
			},
		},
	},
}
