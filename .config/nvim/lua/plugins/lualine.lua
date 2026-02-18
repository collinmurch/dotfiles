return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"echasnovski/mini.icons",
		"ThePrimeagen/harpoon",
	},
	opts = function()
		-- Harpoon component for lualine
		local function harpoon_component()
			local harpoon = require("harpoon")
			local list = harpoon:list()
			local items = list.items

			if #items == 0 then
				return ""
			end

			local current_file = vim.fn.expand("%:p")
			local current_idx = 0
			local marks = {}

			for i, item in ipairs(items) do
				if item.value == current_file then
					current_idx = i
				end
				table.insert(marks, tostring(i))
			end

			local result = table.concat(marks, ",")

			if current_idx > 0 then
				return "󱡀 " .. current_idx .. "/" .. #items
			else
				return "󱠿 " .. #items
			end
		end

		return {
			sections = {
				-- No diff or fileformat sections
				lualine_b = { "branch", "diagnostics" },
				lualine_c = { "filename", harpoon_component },
				lualine_x = { "encoding", "filetype" },
			},
		}
	end,
	init = function()
		require("mini.icons").mock_nvim_web_devicons()
	end,
}
