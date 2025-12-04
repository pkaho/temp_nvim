return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle reveal<CR>", desc = "Neotree" },
		},
		opts = {
			sources_selector = {
				winbar = true,
				statusline = false,
				sources = { -- table
					{
						source = "filesystem", -- string
						display_name = " 󰉓 Files ", -- string | nil
					},
					{
						source = "buffers", -- string
						display_name = " 󰈚 Buffers ", -- string | nil
					},
					{
						source = "git_status", -- string
						display_name = " 󰊢 Git ", -- string | nil
					},
				},
			},
			sources = { "filesystem", "buffers", "git_status", "document_symbols" },

			window = {
				mappings = {
					["w"] = "open_with_window_picker",
					["Y"] = "copy_abosulte_path",
					["h"] = "parent_or_close",
					["l"] = "child_or_open",
					["e"] = "focus_filesystem",
					["g"] = "focus_git",
					["b"] = "focus_buffers",
					["o"] = "focus_symbols",
					["K"] = "go_to_first_sibling",
					["J"] = "go_to_last_sibling",
				},
			},
			commands = {
				system_open = function(state)
					vim.ui.open(state.tree:get_node():get_id())
				end,
				copy_abosulte_path = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					vim.fn.setreg("+", path, "c")
				end,
				focus_filesystem = function()
					vim.api.nvim_exec2("Neotree focus filesystem", { output = true })
				end,
				focus_buffers = function()
					vim.api.nvim_exec2("Neotree focus buffers", { output = true })
				end,
				focus_git = function()
					vim.api.nvim_exec2("Neotree focus git_status", { output = true })
				end,
				focus_symbols = function()
					vim.api.nvim_exec2("Neotree focus document_symbols", { output = true })
				end,
				-- ref: https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/plugins/neo-tree.lua
				parent_or_close = function(state)
					local node = state.tree:get_node()
					if node:has_children() and node:is_expanded() then
						state.commands.toggle_node(state)
					else
						require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
					end
				end,
				child_or_open = function(state)
					local node = state.tree:get_node()
					if node:has_children() then
						if not node:is_expanded() then -- if unexpanded, expand
							state.commands.toggle_node(state)
						else -- if expanded and has children, seleect the next child
							if node.type == "file" then
								state.commands.open(state)
							else
								require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
							end
						end
					else -- if has no children
						state.commands.open(state)
					end
				end,
				-- Go to first/last sibling
				-- refer: https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/220
				go_to_last_sibling = function(state)
					local tree = state.tree
					local node = tree:get_node()
					local siblings = tree:get_nodes(node:get_parent_id())
					local renderer = require("neo-tree.ui.renderer")
					renderer.focus_node(state, siblings[#siblings]:get_id())
				end,
				go_to_first_sibling = function(state)
					local tree = state.tree
					local node = tree:get_node()
					local siblings = tree:get_nodes(node:get_parent_id())
					local renderer = require("neo-tree.ui.renderer")
					renderer.focus_node(state, siblings[1]:get_id())
				end,
			},
		},
	},

	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim", -- makes sure that this loads after Neo-tree.
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},

	{
		"s1n7ax/nvim-window-picker",
		version = "2.*",
		config = function()
			require("window-picker").setup({
				filter_rules = {
					include_current_win = false,
					autoselect_one = true,
					-- filter using buffer options
					bo = {
						-- if the file type is one of following, the window will be ignored
						filetype = { "neo-tree", "neo-tree-popup", "notify" },
						-- if the buffer type is one of following, the window will be ignored
						buftype = { "terminal", "quickfix" },
					},
				},
			})
		end,
	},
}
