return {
	-- 快捷键提示
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts_extend = { "spec" },
		opts = {
			preset = "helix", -- classic, modern, helix
			spec = {
				{
					mode = { "n", "v" },
					{ "<leader><tab>", group = "tabs" },
					{ "gs", group = "surround" },
				},
			},
			icons = {
				mappings = false,
				breadcrumb = "»", -- 面包屑(路径导航)
				separator = "➜", -- 快捷键和说明之间的分隔符
				group = "+", -- 快捷键组, 某个单词作为多个快捷键的前缀时显示
			},
			plugins = {
				marks = true, -- 使用 ' 或 ` 显示 marks 列表
				registers = true, -- 在 NORMAL 模式使用"显示寄存器中的复制内容
				spelling = {
					enabled = true, -- 按下 z= 显示拼写检查列表
					suggestions = 20, -- 列表长度
				},
				presets = {
					operators = true, -- 显示操作符帮助, 如 d(删除)、y(复制)、c(修改)等
					motions = true, -- 显示移动操作帮助, 比如dw(删除到下一个单词开头)
					text_objects = true, -- 显示文本对象帮助, nvim的ai操作
					windows = true, -- 显示 Ctrl+w 相关的窗口操作快捷键
					nav = true, -- 显示窗口导航相关的其他绑定
					z = true, -- 显示 z 快捷键开头的操作, 比如折叠(zd)
					g = true, -- 显示 g 快捷键开头的操作, 比如打开路径(gx)
				},
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},

	-- easymotion
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},

	-- 预览命令行输入的行号处的内容
	{
		"nacro90/numb.nvim",
		event = "VeryLazy",
		opts = {
			show_numbers = true,
			show_cursorline = true,
		},
	},
	-- 命令行选择的范围高亮
	{
		"winston0410/range-highlight.nvim",
		opts = {},
	},

	-- 颜色可视化
	{
		"norcalli/nvim-colorizer.lua",
		opts = { "*" },
	},
	-- 颜色选择器
	{
		"uga-rosa/ccc.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{ "<leader>cp", "<cmd>CccPick<cr>", desc = "ColorPick" },
		},
	},

	-- git
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		init = function()
			-- 避免出现 lazygit 出现问题，使用 pwsh 作为默认shell
			local is_enable = false
			if not is_enable then
				return nil
			end

			local is_windows = vim.fn.has("win32") == 1
			local shell = is_windows and (vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell") or nil

			if is_windows and shell then
				vim.opt.shell = shell
				vim.opt.shellcmdflag = "-nologo -noprofile -ExecutionPolicy RemoteSigned -command"
				vim.opt.shellxquote = ""
				vim.notify("LazyGit: Using " .. shell .. " as the default shell", vim.log.levels.INFO)
			end
		end,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},

	-- python 环境选择器
	{
		"linux-cultist/venv-selector.nvim",
		lazy = true,
		dependencies = {
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-dap",
			-- {
			--     "mfussenegger/nvim-dap-python",
			--     config = function()
			--         require('dap-python').setup('uv')
			--     end
			-- }, --optional
			{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
		},
		branch = "regexp", -- This is the regexp branch, use this for the new version
		keys = {
			{ "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Python Venv Select" },
		},
		opts = {
			settings = {
				options = {
					picker = "snacks",
				},
			},
		},
	},

	-- undotree
	{
		"mbbill/undotree",
		dependencies = {
			"sindrets/diffview.nvim",
		},
		init = function()
			-- 参考: https://github.com/mbbill/undotree/issues/168#issuecomment-2267410346
			if vim.fn.has("win32") == 1 then
				vim.g.undotree_DiffCommand = "D:/Applications/Scoop/apps/git/current/usr/bin/diff.exe"
			end
		end,
		keys = {
			{ "<leader>ud", vim.cmd.UndotreeToggle, desc = "ToggleUndoTree" },
		},
	},

	-- better diagnostics list and others
	{
		"folke/trouble.nvim",
		cmd = { "Trouble" },
		opts = {
			modes = {
				lsp = {
					win = { position = "right" },
				},
			},
		},
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
			{
				"<leader>cS",
				"<cmd>Trouble lsp toggle<cr>",
				desc = "LSP references/definitions/... (Trouble)",
			},
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").prev({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next Trouble/Quickfix Item",
			},
		},
	},

	-- todo
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "VeryLazy",
		opts = {},
        -- stylua: ignore
        keys = {
            { "]t",         function() require("todo-comments").jump_next() end,              desc = "Next Todo Comment" },
            { "[t",         function() require("todo-comments").jump_prev() end,              desc = "Previous Todo Comment" },
            { "<leader>xt", "<cmd>Trouble todo toggle<cr>",                                   desc = "Todo (Trouble)" },
            { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
            { "<leader>st", "<cmd>TodoTelescope<cr>",                                         desc = "Todo" },
            { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",                 desc = "Todo/Fix/Fixme" },
        },
	},

	-- markdown 实时渲染
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {
			code = {
				sign = false,
				width = "block",
				right_pad = 1,
			},
			heading = {
				sign = false,
				icons = {},
			},
			checkbox = {
				enabled = false,
			},
		},
		ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
		config = function(_, opts)
			require("render-markdown").setup(opts)
			Snacks.toggle({
				name = "Render Markdown",
				get = require("render-markdown").get,
				set = require("render-markdown").set,
			}):map("<leader>um")
		end,
	},

	-- markdown 浏览器中预览
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = function()
			require("lazy").load({ plugins = { "markdown-preview.nvim" } })
			vim.fn["mkdp#util#install"]()
		end,
		keys = {
			{
				"<leader>cp",
				ft = "markdown",
				"<cmd>MarkdownPreviewToggle<cr>",
				desc = "Markdown Preview",
			},
		},
		config = function()
			vim.cmd([[do FileType]])
		end,
	},
}
