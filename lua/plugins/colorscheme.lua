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
                { name = "ayu",                    colorscheme = "ayu" },
                { name = "ayu-dark",               colorscheme = "ayu-dark" },
                { name = "ayu-light",              colorscheme = "ayu-light" },
                { name = "ayu-mirage",             colorscheme = "ayu-mirage" },
                { name = "catppuccin-frappe",      colorscheme = "catppuccin-frappe" },
                { name = "catppuccin-latte",       colorscheme = "catppuccin-latte" },
                { name = "catppuccin-macchiato",   colorscheme = "catppuccin-macchiato" },
                { name = "catppuccin-mocha",       colorscheme = "catppuccin-mocha" },
                { name = "cyberdream-dark",        colorscheme = "cyberdream" },
                { name = "cyberdream-light",       colorscheme = "cyberdream-light" },
                { name = "everforest",             colorscheme = "everforest" },
                { name = "flexoki-dark",           colorscheme = "flexoki-dark" },
                { name = "flexoki-light",          colorscheme = "flexoki-light" },
                { name = "melange",                colorscheme = "melange" }, -- 跟随终端背景自动调节模式
                { name = "nord",                   colorscheme = "nord" },    -- 无其他模式
                { name = "rose-pine-dawn",         colorscheme = "rose-pine-dawn" },
                { name = "rose-pine-main",         colorscheme = "rose-pine-main" },
                { name = "rose-pine-moon",         colorscheme = "rose-pine-moon" },
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
        dependencies = {
            "mawkler/modicator.nvim",
            enabled = true,
        },
        event = "VeryLazy",
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
        event = "VeryLazy",
        opts = {},
    },

    -- flexoki
    {
        "kepano/flexoki-neovim",
        name = "flexoki",
        event = "VeryLazy",
    },

    -- nord
    {
        "shaunsingh/nord.nvim",
        event = "VeryLazy",
    },

    -- melange
    {
        "savq/melange-nvim",
        event = "VeryLazy",
    },

    -- ayu
    {
        "Shatur/neovim-ayu",
        event = "VeryLazy",
    },

    -- everforest
    {
        "neanias/everforest-nvim",
        event = "VeryLazy",
        config = function()
            require("everforest").setup({
                background = "medium", -- soft, medium, hard
                italics = true,        -- 斜体关键字
            })
        end
    },

    -- synthweave
    {
        "samharju/synthweave.nvim",
        event = "VeryLazy",
    },
}
