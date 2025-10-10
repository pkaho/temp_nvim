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
                    { "gs",            group = "surround" },
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
                    picker = 'snacks'
                }
            }
        },
    },

    -- undotree
    {
        "mbbill/undotree",
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

    -- diff 工具
    {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
        opts = {},
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
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
            { "<leader>cs", "<cmd>Trouble symbols toggle<cr>",                  desc = "Symbols (Trouble)" },
            { "<leader>cS", "<cmd>Trouble lsp toggle<cr>",                      desc = "LSP references/definitions/... (Trouble)" },
            { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                  desc = "Location List (Trouble)" },
            { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix List (Trouble)" },
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

    -- 浮动状态栏, winbar 的替代方案
    -- {
    -- 	"b0o/incline.nvim",
    -- 	dependencies = {
    -- 		"SmiteshP/nvim-navic",
    -- 	},
    -- 	event = "VeryLazy",
    -- 	config = function()
    -- 		local helpers = require("incline.helpers")
    -- 		local navic = require("nvim-navic")
    -- 		local devicons = require("nvim-web-devicons")
    -- 		navic.setup({
    -- 			highlight = true,
    -- 			depth_limit = 5,
    -- 			lsp = {
    -- 				auto_attach = true,
    -- 			},
    -- 		})
    -- 		require("incline").setup({
    -- 			window = {
    -- 				padding = 0,
    -- 				margin = { horizontal = 0, vertical = 0 },
    -- 			},
    -- 			render = function(props)
    -- 				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
    -- 				if filename == "" then
    -- 					filename = "[No Name]"
    -- 				end
    -- 				local ft_icon, ft_color = devicons.get_icon_color(filename)
    -- 				local modified = vim.bo[props.buf].modified
    -- 				local res = {
    -- 					ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
    -- 						or "",
    -- 					" ",
    -- 					{ filename, gui = modified and "bold,italic" or "bold" },
    -- 					guibg = "#44406e",
    -- 				}
    -- 				if props.focused then
    -- 					for _, item in ipairs(navic.get_data(props.buf) or {}) do
    -- 						table.insert(res, {
    -- 							{ " > ", group = "NavicSeparator" },
    -- 							{ item.icon, group = "NavicIcons" .. item.type },
    -- 							{ item.name, group = "NavicText" },
    -- 						})
    -- 					end
    -- 				end
    -- 				table.insert(res, " ")
    -- 				return res
    -- 			end,
    -- 		})
    -- 	end,
    -- },
}
