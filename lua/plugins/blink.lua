return {
	-- 补全插件
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			completion = { documentation = { auto_show = false } },
			cmdline = {
				enabled = true,
				keymap = { preset = "cmdline" },
				completion = {
					list = { selection = { preselect = false } },
					menu = {
						auto_show = function(ctx)
							return vim.fn.getcmdtype() == ":"
						end,
					},
					ghost_text = { enabled = true },
				},
			},
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- 让 lazydev 提示在菜单优先显示，(see: `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
		},
	},

	-- 自动格式化
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- 对没有良好编码风格标准的语言禁用"format_on_save lsp_fallback"
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return {
						timeout_ms = 500,
						lsp_format = "fallback",
					}
				end
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform也可以按顺序运行多个格式化工具
				-- python = { "isort", "black" },
				python = { "ruff" },
			},
		},
	},

	-- 右下角显示 lsp 信息，类似 lsp-progress
	-- { "j-hui/fidget.nvim", opts = {} },
}
