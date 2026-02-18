return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-go",
	},
	keys = {
		{
			"<leader>tr",
			function()
				require("neotest").run.run()
			end,
			desc = "Run nearest test",
		},
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "Debug nearest test",
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run file",
		},
		{
			"[t",
			function()
				require("neotest").jump.prev()
			end,
			desc = "Previous test",
		},
		{
			"]t",
			function()
				require("neotest").jump.next()
			end,
			desc = "Next test",
		},
		{
			"<leader>ta",
			function()
				require("neotest").run.run({ suite = true })
			end,
			desc = "Run all tests",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true })
			end,
			desc = "Output of nearest test",
		},
		{
			"<leader>tp",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Toggle raw output panel",
		},
		{
			"<leader>tt",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle summary",
		},
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-go"),
			},
			icons = {
				failed = "✘",
				passed = "✓",
				running = "◌",
				skipped = "-",
				unknown = "?",
			},
			highlights = {
				failed = "DiagnosticError",
				passed = "DiagnosticOk",
				running = "DiagnosticInfo",
				skipped = "Comment",
				test = "DiagnosticHint",
				namespace = "DiagnosticInfo",
				focused = "DiagnosticWarn",
			},
		})
	end,
}
