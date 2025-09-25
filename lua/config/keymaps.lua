vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

map("i", "jk", "<Esc>", { desc = "Quit Insert Mode" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map({ "n", "i", "x", "s" }, "<C-s>", "<cmd>w<CR><esc>", { desc = "Save File" })
map("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Lazy" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<leader>R", "<cmd>source $MYVIMRC<CR>", { desc = "Reload Config" })
map("n", "<leader>qq", "<cmd>qall<CR>", { desc = "Quit" })

-- wrap 启用的时候, 不会跳过续行
map({ "n", "x" }, "j", 'v:count == 0 ? "gj" : "j"', { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", 'v:count == 0 ? "gj" : "j"', { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", 'v:count == 0 ? "gk" : "k"', { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", 'v:count == 0 ? "gk" : "k"', { desc = "Up", expr = true, silent = true })
map({ "n", "v", "o" }, "gh", "^", { desc = "To the start of the line" })
map({ "n", "v", "o" }, "gl", "$", { desc = "To the end of the line" })

-- 在窗口之间移动
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- 分割窗口
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>\\", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

-- visual模式下, 更方便的缩进
map("v", "<", "<gv")
map("v", ">", ">gv")

-- 快速将当前行向上/下移动
map("n", "<A-j>", '<cmd>execute "move .+" . v:count1<CR>==', { desc = "Move Down" })
map("n", "<A-k>", '<cmd>execute "move .-" . (v:count1 + 1)<CR>==', { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<CR>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<CR>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<CR>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<CR>gv=gv", { desc = "Move Up" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- 在/或者?的搜索模式中, n始终向下, N始终向上
map("n", "n", '"Nn"[v:searchforward]."zv"', { expr = true, desc = "Next Search Result" })
map("x", "n", '"Nn"[v:searchforward]', { expr = true, desc = "Next Search Result" })
map("o", "n", '"Nn"[v:searchforward]', { expr = true, desc = "Next Search Result" })
map("n", "N", '"nN"[v:searchforward]."zv"', { expr = true, desc = "Prev Search Result" })
map("x", "N", '"nN"[v:searchforward]', { expr = true, desc = "Prev Search Result" })
map("o", "N", '"nN"[v:searchforward]', { expr = true, desc = "Prev Search Result" })

-- tabs 相关
map("n", "<leader><tab>l", "<cmd>tablast<CR>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<CR>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<CR>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<CR>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<CR>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<CR>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<CR>", { desc = "Previous Tab" })

-- foldmethod 在手动和表达式之间切换
map("n", "<leader>uf", function()
	if vim.opt.foldmethod:get() == "manual" then
		vim.cmd("set foldmethod=expr")
	else
		vim.cmd("set foldmethod=manual")
	end
	print("Foldmethod: ", vim.opt.foldmethod:get())
end, { desc = "Switch Foldmethod" })
