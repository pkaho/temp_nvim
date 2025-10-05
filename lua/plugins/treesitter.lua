return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		branch = "master",
		lazy = vim.fn.argc(-1) == 0, -- 如果没有打开文件则懒加载
		build = ":TSUpdate",
		-- init = function(plugin)
		--     -- 来源于lazyvim, 部分插件不再主动加载treesitter, 导致功能出问题
		--     -- 但实际上, 这些插件只用到了一小部分功能(比如自定义语法查询)
		--     -- 所以, 在neovim启动时, 提前准备好这一部分功能
		--     require("lazy.core.loader").add_to_rtp(plugin)
		--     require("nvim-treesitter.query_predicates")
		-- end,
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		keys = {
			{ "<BS>", desc = "Decrement Selection", mode = "x" },
			{ "<CR>", desc = "Increment Selection" },
		},
		opts = {
			folding = { enable = true },
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"javascript",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"python",
				"regex",
				"toml",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					node_decremental = "<BS>",
					scope_incremental = "<TAB>",
				},
			},
			textobjects = {
				move = {
					enable = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner",
					},
					goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
						["[A"] = "@parameter.inner",
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	-- 在屏幕顶部显示上下文
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		keys = {
			-- 回到上下文顶部
			{
				"[q",
				function()
					require("treesitter-context").go_to_context(vim.v.count1)
				end,
				desc = "Go to Context",
				mode = { "n", "x" },
				{ slient = true },
			},
		},
		opts = function()
			local tsc = require("treesitter-context")
			Snacks.toggle({
				name = "Treesitter Context",
				get = tsc.enabled,
				set = function(state)
					if state then
						tsc.enable()
					else
						tsc.disable()
					end
				end,
			}):map("<leader>ut")
			return { mode = "cursor", max_lines = 3 }
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "VeryLazy",
		opts = {
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				-- LazyVim extention to create buffer-local keymaps
				keys = {
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner",
					},
					goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
						["[A"] = "@parameter.inner",
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter-textobjects").setup(opts)
			-- vim.api.nvim_create_autocmd("FileType", {
			-- 	group = vim.api.nvim_create_augroup("lazyvim_treesitter_textobjects", { clear = true }),
			-- 	callback = function(ev)
			--
			-- 			---@type table<string, table<string, string>>
			-- 			local moves = vim.tbl_get(opts, "move", "keys") or {}
			--
			-- 			for method, keymaps in pairs(moves) do
			-- 				for key, query in pairs(keymaps) do
			-- 					local desc = query:gsub("@", ""):gsub("%..*", "")
			-- 					desc = desc:sub(1, 1):upper() .. desc:sub(2)
			-- 					desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
			-- 					desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")
			-- 					if not (vim.wo.diff and key:find("[cC]")) then
			-- 						vim.keymap.set({ "n", "x", "o" }, key, function()
			-- 							require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
			-- 						end, {
			-- 							buffer = ev.buf,
			-- 							desc = desc,
			-- 							silent = true,
			-- 						})
			-- 					end
			-- 				end
			-- 			end
			-- 	end,
			-- })
		end,
	},
}
