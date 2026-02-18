return {
	"saghen/blink.cmp",
	-- Stay on a tagged release so prebuilt fuzzy binaries match the Lua side.
	version = "v1.8.0",
	dependencies = {
		"folke/lazydev.nvim",
	},
	opts = {
		keymap = {
			preset = "default",
			["<Tab>"] = { "accept", "fallback" },
			["<CR>"] = { "accept", "fallback" },
		},
		completion = {
			documentation = { auto_show = true },
		},
		sources = {
			default = { "lsp", "path", "buffer" },
			per_filetype = {
				lua = { "lazydev" },
			},
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
				},
			},
		},
		fuzzy = {
			implementation = "prefer_rust_with_warning",
			frecency = {
				enabled = true,
			},
		},
	},
}
