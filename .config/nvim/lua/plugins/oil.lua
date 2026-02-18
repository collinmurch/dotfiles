return {
	"stevearc/oil.nvim",
	event = "VimEnter",
	dependencies = {
		{ "echasnovski/mini.icons", opts = {} },
	},
	opts = {
		delete_to_trash = true,
		skip_confirm_for_simple_edits = true,
		view_options = {
			show_hidden = true,
			natural_order = true,
			is_always_hidden = function(name, _)
				return name == ".." or name == ".git"
			end,
		},
		float = {
			padding = 5,
			max_width = 90,
		},
		win_options = {
			wrap = true,
		},
		use_default_keymaps = false,
		keymaps = {
			["<CR>"] = "actions.select",
			["<Esc>"] = "actions.close",
			["-"] = { "actions.parent", mode = "n" },
			["<leader>k"] = { "actions.preview", desc = "Preview file" },
			["<leader>r"] = { "actions.refresh", desc = "Refresh directory" },
			["<leader>."] = { "actions.toggle_hidden", desc = "Toggle hidden files" },
			["<leader>g"] = { "actions.toggle_trash", desc = "Toggle trash" },
		},
	},
	keys = {
		{
			"\\",
			function()
				require("oil").toggle_float()
			end,
			desc = "Toggle Oil file explorer",
		},
	},
}
