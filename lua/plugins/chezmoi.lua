local pick_chezmoi_fzf = function()
    local fzf_lua = require("fzf-lua")
    local actions = {
        ["enter"] = function(selected)
            fzf_lua.actions.vimcmd_entry("ChezmoiEdit", selected, { cwd = os.getenv("HOME") })
        end,
    }
    fzf_lua.files({ cmd = "chezmoi managed --include=files,symlinks", actions = actions, hidden = false })
end

local pick_chezmoi_telescope = function()
    require("telescope").extensions.chezmoi.find_files()
end

local pick_chezmoi_snacks = function()
    local results = require("chezmoi.commands").list({
        args = {
            "--path-style",
            "absolute",
            "--include",
            "files",
            "--exclude",
            "externals",
        },
    })
    local items = {}

    for _, czFile in ipairs(results) do
        table.insert(items, {
            text = czFile,
            file = czFile,
        })
    end

    ---@type snacks.picker.Config
    local opts = {
        items = items,
        confirm = function(picker, item)
            picker:close()
            require("chezmoi.commands").edit({
                targets = { item.text },
                args = { "--watch" },
            })
        end,
    }
    Snacks.picker.pick(opts)
end

return {
    {
        "alker0/chezmoi.vim",
        init = function()
            vim.g["chezmoi#use_tmp_buffer"] = 1
            vim.g["chezmoi#source_dir_path"] = os.getenv("HOME") .. "/.local/share/chezmoi"
        end,
    },

    {
        "xvzc/chezmoi.nvim",
        cmd = { "ChezmoiEdit" },
        keys = {
            { "<leader>sz", pick_chezmoi_snacks, desc = "Chezmoi" },
        },
        opts = {
            edit = {
                watch = true,
                force = false,
            },
            notification = {
                on_open = true,
                on_apply = true,
                on_watch = false,
            },
            telescope = {
                select = { "<CR>" },
            },
        },
        -- 将修改同步到本地, 需要 opts.edit.watch = true
        init = function()
            vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
                -- 需要创建一个名为 HOME 的系统变量
                pattern = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
                callback = function(ev)
                    local bufnr = ev.buf
                    local edit_watch = function()
                        require("chezmoi.commands.__edit").watch(bufnr)
                    end
                    vim.schedule(edit_watch)
                end,
            })
        end,
    },
}
