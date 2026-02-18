return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		-- All keys in the below table will be auto-installed
		local servers = {
			ruff = {
				init_options = {
					settings = {
						organizeImports = true,
						fixAll = true,
					},
				},
			},
			zls = {},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
					},
				},
			},
			gopls = {
				settings = {
					gopls = {
						gofumpt = true,
						buildFlags = { "-tags=integrationtest,integration,manual,wireinject" },
						hints = {
							constantValues = true,
							parameterNames = true,
						},
					},
				},
			},
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						checkOnSave = {
							command = "clippy",
						},
						procMacro = {
							enable = true,
						},
						cargo = {
							allFeatures = true,
						},
					},
				},
			},
			vtsls = {
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			},
			biome = {
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "jsonc" },
			},
			svelte = {
				settings = {
					svelte = {
						plugin = {
							typescript = {
								enable = true,
							},
							css = true,
							svelte = {
								defaultScriptLanguage = "typescript",
								useNewTransformation = true,
							},
						},
					},
				},
				filetypes = { "svelte" },
			},
		}

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function()
				local map = vim.keymap.set

				map("n", "[d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
				map("n", "]d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
				map("n", "gd", vim.lsp.buf.definition, { desc = "Goto definitions" })
				map("n", "gr", vim.lsp.buf.references, { desc = "Goto references" })
				map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
				map("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Perform code action" })
				map("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })
			end,
		})

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(servers),
			automatic_installation = true,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
