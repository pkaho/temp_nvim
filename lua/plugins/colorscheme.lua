return {
	-- theme 选择器
	{
		"zaldih/themery.nvim",
		lazy = false,
		keys = {
			{ "<leader>uc", "<cmd>Themery<cr>", desc = "Select Color Theme" },
		},
		opts = {
            -- stylua: ignore
			themes = {
				-- { name = "----------------- Light -----------------" },
				{ name = "catppuccin-latte",       colorscheme = "catppuccin-latte" },
				{ name = "catppuccin-mocha",       colorscheme = "catppuccin-mocha" },
				{ name = "catppuccin-frappe",      colorscheme = "catppuccin-frappe" },
				{ name = "catppuccin-macchiato",   colorscheme = "catppuccin-macchiato" },
				{ name = "cyberdream-dark",        colorscheme = "cyberdream" },
				{ name = "cyberdream-light",       colorscheme = "cyberdream-light" },
				{ name = "rose-pine-dawn",         colorscheme = "rose-pine-dawn" },
				{ name = "rose-pine-moon",         colorscheme = "rose-pine-moon" },
				{ name = "rose-pine-main",         colorscheme = "rose-pine-main" },
				{ name = "flexoki-dark",           colorscheme = "flexoki-dark" },
				{ name = "flexoki-light",          colorscheme = "flexoki-light" },
				{ name = "nord",                   colorscheme = "nord" },    -- 无其他模式
				{ name = "melange",                colorscheme = "melange" }, -- 跟随终端背景自动调节模式
				{ name = "synthweave",             colorscheme = "synthweave" },
				{ name = "synthweave-transparent", colorscheme = "synthweave-transparent" },
			},
			livePreview = true,
		},
	},

	-- rose-pine
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	},

	-- cyberdream
	{
		"scottmckendry/cyberdream.nvim",
		lazy = true,
		dependencies = {
			"mawkler/modicator.nvim",
			enabled = true,
		},
		priority = 1000,
		opts = {
			transparent = false,
			italic_comments = true,
			variant = "auto", -- default, auto, light
		},
	},

	-- catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {},
	},

	-- flexoki
	{
		"kepano/flexoki-neovim",
		event = "VeryLazy",
		name = "flexoki",
	},

	-- nord
	{
		"shaunsingh/nord.nvim",
		event = "VeryLazy",
	},

	-- melange
	{
		"savq/melange-nvim",
	},

	{
		"samharju/synthweave.nvim",
	},
}
