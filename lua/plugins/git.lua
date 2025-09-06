return {
	-- gitsigns
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	-- git blame
	{
		"f-person/git-blame.nvim",
		event = "VeryLazy",
		opts = {},
	},
}
