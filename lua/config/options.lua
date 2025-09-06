-- `:h option-list`
-- `:h nvim-features` options 部分
-- opt 和 vim.vim.o 部分情况不一样，详情见：`:h lua-options`

local opt = vim.opt
local tab_size = 4

-- 在 `UiEnter` 事件后设置，因为可能会增加启动时间
vim.schedule(function()
	opt.clipboard = "unnamedplus" -- 同步系统剪贴板(需要xclip/wl-clipboard)
end)
opt.mouse = "a" -- 全模式鼠标支持
opt.timeoutlen = 300 -- 按键超出时间
opt.updatetime = 200 -- 控制 CursorHold 事件触发和 swap 文件写入的延迟时间（毫秒）

-- 补全功能
opt.completeopt = "menu,menuone,noselect" -- 插入模式补全菜单逻辑
opt.wildmode = "longest:full,full" -- 命令行 tab 补全逻辑

-- 文件和缓冲区行为
opt.hidden = true -- 在未保存当前文件修改的情况下切换缓冲区，autowrite 失败时生效
opt.autowrite = true -- 切换缓冲区或执行某些命令时自动保存当前文件的修改
opt.confirm = true -- 退出时提示未保存确认对话框

-- 显示效果
opt.termguicolors = true -- 设置 24bit(1670万色)，传统只支持 8bit(256色)
opt.cursorline = true -- 高亮当前行
opt.list = true -- 显示不可见字符
-- opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- 不可见字符显示样式
opt.laststatus = 3 -- 全局状态栏，所有窗口共享一个状态栏
opt.showmode = false -- 模式显示，用状态栏插件代替
opt.ruler = false -- 状态栏显示光标位置，用状态栏插件代替
opt.virtualedit = "block" -- 可视块模式下允许光标移动到无文本处
opt.conceallevel = 2 -- 隐藏某些文本(如 Markdown 的粗/斜体标记)

-- 折行
opt.wrap = false -- 超出屏幕自动折行显示
opt.linebreak = true -- 在单词边界折行
opt.breakindent = true -- 在折行时保持缩进
--opt.showbreak = '↪ ' -- 续行标识符号

-- 行列设置
opt.number = true -- 行号显示
opt.relativenumber = true -- 相对行号
opt.signcolumn = "yes" -- 显示符号列
opt.numberwidth = 4 -- 行号列宽度

-- Tab 缩进
opt.expandtab = true -- Tab 转换成空格
opt.tabstop = tab_size -- Tab 显示的宽度
opt.softtabstop = tab_size -- 编辑时tab键插入的空格数
opt.shiftwidth = tab_size -- 自动缩进宽度
opt.shiftround = true -- 缩进时对齐到 shiftwidth 的倍数
opt.smartindent = true -- 代码块自主缩进(如if、for等)

-- 搜索和替换
opt.ignorecase = true -- 搜索忽略大小写
opt.smartcase = true -- 有大写时精确搜索
opt.inccommand = "split" -- 预览 substitutions live 命令
opt.grepformat = "%f:%l:%c:%m" -- 设置 grep 输出格式
if vim.fn.executable("rg") == 1 then
	-- 使用 ripgrep 加速 :grep 搜索
	-- `--vimgrep` 生成兼容 vim quickfix 的搜索结果
	opt.grepprg = "rg --vimgrep"
end

-- 撤销
opt.undofile = true -- 持久化撤销历史，存在 undodir 指定的目录中
opt.undolevels = 12345 -- 最大撤销步数

-- 窗口设置
opt.splitbelow = true -- 新窗口在下方打开
opt.splitright = true -- 新窗口在右侧打开
opt.splitkeep = "screen" -- 分割的窗口保持屏幕滚动位置
opt.winminwidth = 10 -- 全局窗口最小宽度

-- 滚动
opt.scrolloff = 4 -- 光标距离窗口顶部/底部保留的行数
opt.sidescrolloff = 8 -- 光标距离窗口左右边缘保留的列数

-- 补全菜单视觉效果
opt.pumblend = 10 -- 弹出菜单透明度
opt.pumheight = 10 -- 弹出菜单最大显示行数
opt.winblend = 0 -- 浮动窗口透明度

-- 文件备份策略
opt.swapfile = true -- .swp 交换文件，成功保存后自动删除
opt.writebackup = true -- ~ 备份文件，成功保存后自动删除
opt.backup = false -- 永久保留 ~ 备份文件，除非手动删除
-- 跳过生成 ~ 备份文件类型
opt.backupskip = {
	"/tmp/*", -- 临时文件
	"/private/tmp/*", -- macOS 临时文件
	"*.swp", -- Vim 交换文件
	"*.bak", -- 备份文件
	"*.pyc", -- Python 字节码
	"*.class", -- Java 字节码
	"*.o", -- 编译对象文件
	"node_modules/*", -- Node.js 依赖
	".git/*", -- Git 目录
	".svn/*", -- SVN 目录
	"__pycache__/*", -- Python 缓存
}
