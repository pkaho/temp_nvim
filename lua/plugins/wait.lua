return {
	-- 多光标
	{
		"jake-stewart/multicursor.nvim",
		enabled = false,
		branch = "1.0",
		opts = {},
	},

	-- Neovim的任务运行器和作业管理插件
	{
		"stevearc/overseer.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {},
	},

	-- 像 Cursor 一样
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		enabled = false,
		lazy = true,
		opts = {},
	},
}
