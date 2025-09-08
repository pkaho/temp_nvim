vim.diagnostic.config({
	float = {
		border = "rounded",
	},
	underline = true,
	update_in_insert = false,
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = "●",
		format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = diagnostic.message,
				[vim.diagnostic.severity.WARN] = diagnostic.message,
				[vim.diagnostic.severity.INFO] = diagnostic.message,
				[vim.diagnostic.severity.HINT] = diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
		end,
	},
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
})

return {
	-- lsp 配置
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		config = function()
			vim.lsp.enable({
				"lua_ls",
				"basedpyright",
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
					end
					map("gd", vim.lsp.buf.definition, "Goto Definition")
					map("gD", vim.lsp.buf.declaration, "Goto Declaration")
					map("gr", vim.lsp.buf.references, "Reference")
					map("gI", vim.lsp.buf.implementation, "Goto Implementation")
					map("gy", vim.lsp.buf.type_definition, "Goto Type Definition")
					map("K", vim.lsp.buf.hover, "Hover")
					map("gK", vim.lsp.buf.signature_help, "signatureHelp")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
					map("<leader>cc", vim.lsp.codelens.run, "Run Codelens")
					map("<leader>cC", vim.lsp.codelens.refresh, "Refresh & Display")
					map("<leader>cr", vim.lsp.buf.rename, "Rename")
					map("<leader>cd", vim.diagnostic.open_float, "Show diagnostics in a floating window")
					map("]]", function()
						Snacks.words.jump(vim.v.count1)
					end, "Next Reference")
					map("[[", function()
						Snacks.words.jump(-vim.v.count1)
					end, "Prev Reference")
					map("[d", function()
						vim.diagnostic.jump({ count = 1, float = { border = "rounded" } })
					end, "Goto Prev Diagnostic")
					map("]d", function()
						vim.diagnostic.jump({ count = -1, float = { border = "rounded" } })
					end, "Goto Prev Diagnostic")

					local function client_supports_method(client, method, bufnr)
						return client:supports_method(method, bufnr)
					end

					local inlayHint = vim.lsp.protocol.Methods.textDocument_inlayHint
					if client and client_supports_method(client, inlayHint, args.buf) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }))
						end, "Toggle Inlay Hints")
					else
						vim.notify("LSP dose not support Inlay Hints")
					end
				end,
			})

			-- 自动折叠 imports
			vim.api.nvim_create_autocmd("LspNotify", {
				callback = function(args)
					if args.data.method == "textDocument/didOpen" then
						vim.lsp.foldclose("imports", vim.fn.bufwinid(args.buf))
					end
				end,
			})
		end,
	},

	{ "mason-org/mason.nvim", opts = {} },
	-- lsp 下载
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
			},
		},
	},

	-- 使用 lazydev 增加 neovim 相关的补全
	{
		"folke/lazydev.nvim",
		ft = "lua",
		cmd = "LazyDev",
		opts = {
			library = {
				-- 当找到 `vim.uv` 单词时加载 luvit 类型
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "lazy.nvim", words = { "LazyVim" } },
			},
		},
	},
}
