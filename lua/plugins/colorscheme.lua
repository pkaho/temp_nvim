return {
    -- 主题选择器
    {
        "zaldih/themery.nvim",
        lazy = false, -- 必须 eager 加载, 否则 <leader>uc 无法使用
        keys = {
            { "<leader>uc", "<cmd>Themery<CR>", desc = "Select Color Theme" },
        },
        dependencies = {
            -- 所有支持的主题插件作为依赖
            "Shatur/neovim-ayu",
            "catppuccin/nvim",
            "kepano/flexoki-neovim",
            "rose-pine/neovim",
            "sainnhe/sonokai",
            "erikbackman/brightburn.vim",
            "maxmx03/solarized.nvim",
        },
        priority = 1000,
        opts = {
            livePreview = true,
            -- stylua:ignore
            themes = {
                -- Light Themes
                { name = "ayu-light",            colorscheme = "ayu-light" },
                { name = "catppuccin-latte",     colorscheme = "catppuccin-latte" },
                { name = "flexoki-light",        colorscheme = "flexoki-light" },
                { name = "rose-pine-dawn",       colorscheme = "rose-pine-dawn" },
                { name = "solarized",            colorscheme = "solarized",           before = [[vim.o.background = 'light']] },

                -- Dark Themes
                { name = "ayu-dark",             colorscheme = "ayu-dark" },
                { name = "ayu-mirage",           colorscheme = "ayu-mirage" },
                { name = "brightburn",           colorscheme = "brightburn" },
                { name = "catppuccin-frappe",    colorscheme = "catppuccin-frappe" },
                { name = "catppuccin-macchiato", colorscheme = "catppuccin-macchiato" },
                { name = "catppuccin-mocha",     colorscheme = "catppuccin-mocha" },
                { name = "flexoki-dark",         colorscheme = "flexoki-dark" },
                { name = "rose-pine-main",       colorscheme = "rose-pine-main" },
                { name = "rose-pine-moon",       colorscheme = "rose-pine-moon" },
                { name = "sonokai-andromeda",    colorscheme = "sonokai",             before = [[vim.g.sonokai_style='andromeda']] },
                { name = "sonokai-atlantis",     colorscheme = "sonokai",             before = [[vim.g.sonokai_style='atlantis']] },
                { name = "sonokai-default",      colorscheme = "sonokai",             before = [[vim.g.sonokai_style='default']] },
                { name = "sonokai-espresso",     colorscheme = "sonokai",             before = [[vim.g.sonokai_style='espresso']] },
                { name = "sonokai-maia",         colorscheme = "sonokai",             before = [[vim.g.sonokai_style='maia']] },
                { name = "sonokai-shusia",       colorscheme = "sonokai",             before = [[vim.g.sonokai_style='shusia']] },
                { name = "solarized",            colorscheme = "solarized",           before = [[vim.o.background = 'dark']] },
            },
        },
    },

    -- 各主题插件: 仅加载, 不启用 colorscheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        opts = {
            flavour = "mocha", -- 默认值, 实际由 themery 切换时决定
        },
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
    },
}
