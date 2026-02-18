return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			update_debounce = 100,

			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				map("n", "]g", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]g", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Next change" })

				map("n", "[g", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[g", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "Previous change" })

				map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Hunk reset" })
				map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Hunk preview" })
				map("n", "<leader>gb", gitsigns.blame_line, { desc = "Blame line" })
				map("n", "<leader>gt", function()
					local gitsigns = require("gitsigns")
					gitsigns.toggle_deleted()
					gitsigns.toggle_linehl()
				end, { desc = "Toggle diff" })

				map("v", "<leader>hr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "reset git hunk" })
			end,
		},
	},
}
