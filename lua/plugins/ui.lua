return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        init = function()
            vim.g.snacks_animate = false
        end,
        -- stylua: ignore
        keys = {
            { "<leader><Space>", "<cmd>lua Snacks.picker.files()<CR>",         desc = "File Search" },
            { "<leader>/",       "<cmd>lua Snacks.picker.grep()<CR>",          desc = "Grep" },
            { '<leader>"',       "<cmd>lua Snacks.picker.registers()<CR>",     desc = "Registers" },
            { "<leader>sh",      "<cmd>lua Snacks.picker.help()<CR>",          desc = "Search Help" },
            { "<leader>sb",      "<cmd>lua Snacks.picker.grep_buffers()<CR>",  desc = "Grep inside Buffers" },
            { "<leader>sp",      "<cmd>lua Snacks.picker.projects()<CR>",      desc = "Search .git Projects" },
            { "<leader>sk",      "<cmd>lua Snacks.picker.keymaps()<CR>",       desc = "Search Keymaps" },
            { "<leader>st",      "<cmd>lua Snacks.picker.todo_comments()<CR>", desc = "Search Todo" },
            { "<leader>,",       "<cmd>lua Snacks.picker.buffers()<CR>",       desc = "Search Buffers" },
            { "<leader>e",       "<cmd>lua Snacks.explorer()<CR>",             desc = "Explorer" },
            { "<leader>cz",      "<cmd>lua Snacks.zen.zoom()<CR>",             desc = "Toggle Zoom" },
            { "<leader>cZ",      "<cmd>lua Snacks.zen()<CR>",                  desc = "Toggle Zen" },
            { "<c-/>",           function() Snacks.terminal() end,             desc = "Toggle Terminal" },
            { "<c-_>",           function() Snacks.terminal() end,             desc = "which_key_ignore" },
        },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            dashboard = {
                preset = {
                    header = [[]],
                },
                enabled = true,
            },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = false },
            words = { enabled = true },
            picker = {
                hidden = true,                 -- 显示 explorer 中的隐藏文件
                sources = {
                    files = { hidden = true }, -- 显示 picker 中的隐藏文件
                    explorer = {
                        layout = {
                            auto_hide = { "input" }, -- 隐藏搜索框, 只有按下 / 或者 i 才会显示
                        },
                    },
                },
            },
        },
    },

    -- 会话管理, 用于快速恢复上次打开的状态
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        keys = {
            {
                "<leader>qs",
                function()
                    require("persistence").load()
                end,
                desc = "Restore Session",
            },
            {
                "<leader>qS",
                function()
                    require("persistence").select()
                end,
                desc = "Select Session",
            },
            {
                "<leader>ql",
                function()
                    require("persistence").load({ last = true })
                end,
                desc = "Restore Last Session",
            },
            {
                "<leader>qd",
                function()
                    require("persistence").stop()
                end,
                desc = "Don't Save Current Session",
            },
        },
        opts = {},
    },

    -- 消息菜单
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            views = {
                cmdline_popup = {
                    position = {
                        row = "30%", -- 将 command_palette 放在靠近屏幕中间的地方, 默认为 3
                        col = "50%",
                    },
                },
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "%d+L, %d+B" },
                            { find = "; after #%d+" },
                            { find = "; before #%d+" },
                        },
                    },
                    view = "mini",
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false, -- 激活 inc-rename.nvim 的输入对话框
            },
        },
        -- stylua: ignore
        keys = {
            { "<leader>sn",  "",                                                                            desc = "+noice" },
            { "<S-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end,                 mode = "c",                              desc = "Redirect Cmdline" },
            { "<leader>snl", function() require("noice").cmd("last") end,                                   desc = "Noice Last Message" },
            { "<leader>snh", function() require("noice").cmd("history") end,                                desc = "Noice History" },
            { "<leader>sna", function() require("noice").cmd("all") end,                                    desc = "Noice All" },
            { "<leader>snd", function() require("noice").cmd("dismiss") end,                                desc = "Dismiss All" },
            { "<leader>snt", function() require("noice").cmd("pick") end,                                   desc = "Noice Picker (Telescope/FzfLua)" },
            { "<c-f>",       function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,  silent = true,                           expr = true,              desc = "Scroll Forward",  mode = { "i", "n", "s" } },
            { "<c-b>",       function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true,                           expr = true,              desc = "Scroll Backward", mode = { "i", "n", "s" } },
        },
        config = function(_, opts)
            -- HACK: noice shows messages from before it was enabled,
            -- but this is not ideal when Lazy is installing plugins,
            -- so clear the messages in this case.
            if vim.o.filetype == "lazy" then
                vim.cmd([[messages clear]])
            end
            require("noice").setup(opts)
        end,
    },
}
