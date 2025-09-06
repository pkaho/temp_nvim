return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        init = function()
            vim.g.snacks_animate = false
        end,
        keys = {
            { "<leader><Space>", "<cmd>lua Snacks.picker.files()<CR>",     desc = "File Search" },
            { "<leader>/",       "<cmd>lua Snacks.picker.grep()<CR>",      desc = "Grep" },
            { "<leader>\"",      "<cmd>lua Snacks.picker.registers()<CR>", desc = "Registers" },
            { "<leader>sh",      "<cmd>lua Snacks.picker.help()<CR>",      desc = "Search Help" },
            { "<leader>sb",      "<cmd>lua Snacks.picker.buffers()<CR>",   desc = "Search Buffers" },
            { "<leader>e",       "<cmd>lua Snacks.explorer()<CR>",         desc = "Explorer" },
            { "<leader>cz",      "<cmd>lua Snacks.zen.zoom()<CR>",         desc = "Toggle Zoom" },
            { "<leader>cZ",      "<cmd>lua Snacks.zen()<CR>",              desc = "Toggle Zen" },
        },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            -- picker = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            picker = {
                sources = {
                    explorer = {
                        layout = {
                            auto_hide = { 'input' } -- 隐藏搜索框, 只有按下 / 或者 i 才会显示
                        }
                    }
                }
            }
        },
    },

    -- 会话管理, 用于快速恢复上次打开的状态
    {
        'folke/persistence.nvim',
        event = 'BufReadPre',
        keys = {
            { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
            { "<leader>qS", function() require("persistence").select() end,              desc = "Select Session" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
            { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
        },
        opts = {},
    },
}
