return {
    {
        "lmantw/themify.nvim",
        lazy = false,
        priority = 999,
        keys = {
            { "<leader>uc", "<cmd>Themify<CR>", desc = "Colorscheme Theme" },
        },

        -- 在这里列出主题插件，自动识别所有变体
        config = function()
            require("themify").setup({
                activity = true,
                -- 只需要写插件地址，自动加载全部主题
                "Shatur/neovim-ayu",          -- ayu-light / ayu-dark / ayu-mirage
                "catppuccin/nvim",            -- 全部 4 种风格自动出现
                "kepano/flexoki-neovim",      -- light / dark
                "rose-pine/neovim",           -- 全部 3 种风格
                "sainnhe/sonokai",            -- 全部风格自动出现
                "erikbackman/brightburn.vim", -- brightburn
                "maxmx03/solarized.nvim",     -- light / dark
            })
        end,
    },

    -- ==============================================
    -- 主题列表
    -- ==============================================
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
    },
    { "Shatur/neovim-ayu",          lazy = true },
    { "kepano/flexoki-neovim",      lazy = true },
    { "sainnhe/sonokai",            lazy = true },
    { "erikbackman/brightburn.vim", lazy = true },
    { "maxmx03/solarized.nvim",     lazy = true },
}
