return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			require("mason-nvim-dap").setup()
			require("dapui").setup()
			require("dap-go").setup()
			require("nvim-dap-virtual-text").setup()

			-- Key mappings
			vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dg", dap.run_to_cursor, { desc = "Run to cursor" })
			vim.keymap.set("n", "<leader>d.", function()
				require("dapui").eval(nil, { enter = true })
			end, { desc = "Evaluate under cursor" })
			vim.keymap.set("n", "<leader>dc", function()
				require("dapui").open({ reset = true })
			end, { desc = "Open DAP UI" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
			vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
			vim.keymap.set("n", "<leader>dx", dap.step_out, { desc = "Step out" })
			vim.keymap.set("n", "<leader>db", dap.step_back, { desc = "Step back" })
			vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Restart" })
			vim.keymap.set("n", "<leader>ds", function()
				dap.close()
				ui.close({ reset = true })
			end, { desc = "Stop debugging" })
			vim.keymap.set("n", "<leader>dl", function()
				require("telescope").extensions.dap.list_breakpoints()
			end, { desc = "List breakpoints" })
			vim.keymap.set("n", "<leader>dv", function()
				require("telescope").extensions.dap.variables()
			end, { desc = "List variables" })
			vim.keymap.set("n", "<leader>df", function()
				require("telescope").extensions.dap.frames()
			end, { desc = "List frames" })
			vim.keymap.set("n", "<leader>dn", dap.continue, { desc = "Start/continue debug" })

			-- DAP listeners
			dap.listeners.after.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.after.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.after.event_terminated.dapui_config = function()
				ui.close({ reset = true })
			end
			dap.listeners.after.event_exited.dapui_config = function()
				ui.close({ reset = true })
			end

			-- Theming
			vim.fn.sign_define("DapBreakpoint", { text = "◌", texthl = "DiagnosticError" })

			vim.api.nvim_set_hl(0, "DapUIScope", { link = "DiagnosticInfo" })
			vim.api.nvim_set_hl(0, "DapUIValue", { link = "DiagnosticFloatingInfo" })
			vim.api.nvim_set_hl(0, "DapUIModifiedValue", { link = "DiagnosticInfo" })
			vim.api.nvim_set_hl(0, "DapUIDecoration", { link = "DiagnosticInfo" })

			vim.api.nvim_set_hl(0, "DapUIThread", { link = "DiagnosticOk" })
			vim.api.nvim_set_hl(0, "DapUIStoppedThread", { link = "DiagnosticWarn" })

			vim.api.nvim_set_hl(0, "DapUIType", { link = "DiagnosticHint" })
			vim.api.nvim_set_hl(0, "DapUISource", { link = "DiagnosticHint" })
			vim.api.nvim_set_hl(0, "DapUILineNumber", { link = "LineNr" })

			vim.api.nvim_set_hl(0, "DapUIWatchesEmpty", { link = "DiagnosticError" })
			vim.api.nvim_set_hl(0, "DapUIWatchesValue", { link = "DiagnosticOk" })
			vim.api.nvim_set_hl(0, "DapUIWatchesError", { link = "DiagnosticError" })

			vim.api.nvim_set_hl(0, "DapUIBreakpointsPath", { link = "DiagnosticInfo" })
			vim.api.nvim_set_hl(0, "DapUIBreakpointsInfo", { link = "DiagnosticOk" })
			vim.api.nvim_set_hl(0, "DapUIBreakpointsDisabledLine", { link = "Comment" })
			vim.api.nvim_set_hl(0, "DapUIBreakpointsCurrentLine", { link = "DiagnosticOk" })

			vim.api.nvim_set_hl(0, "DapUIStepOver", { link = "DiagnosticInfo" })
			vim.api.nvim_set_hl(0, "DapUIStepInto", { link = "DiagnosticInfo" })
			vim.api.nvim_set_hl(0, "DapUIStepBack", { link = "DiagnosticInfo" })
			vim.api.nvim_set_hl(0, "DapUIStepOut", { link = "DiagnosticInfo" })
			vim.api.nvim_set_hl(0, "DapUIStop", { link = "DiagnosticError" })
			vim.api.nvim_set_hl(0, "DapUIPlayPause", { link = "DiagnosticOk" })
			vim.api.nvim_set_hl(0, "DapUIRestart", { link = "DiagnosticOk" })
			vim.api.nvim_set_hl(0, "DapUIUnavailable", { link = "Comment" })

			vim.api.nvim_set_hl(0, "DapUIPlayPauseNC", { link = "DiagnosticOk" })
			vim.api.nvim_set_hl(0, "DapUIRestartNC", { link = "DiagnosticOk" })
			vim.api.nvim_set_hl(0, "DapUIStopNC", { link = "DiagnosticError" })
			vim.api.nvim_set_hl(0, "DapUIUnavailableNC", { link = "Comment" })
			vim.api.nvim_set_hl(0, "DapUIStepOverNC", { link = "DiagnosticInfo" })
			vim.api.nvim_set_hl(0, "DapUIStepIntoNC", { link = "DiagnosticInfo" })
			vim.api.nvim_set_hl(0, "DapUIStepBackNC", { link = "DiagnosticInfo" })
			vim.api.nvim_set_hl(0, "DapUIStepOutNC", { link = "DiagnosticInfo" })

			vim.api.nvim_set_hl(0, "DapUIFloatBorder", { link = "FloatBorder" })
			vim.api.nvim_set_hl(0, "DapUIWinSelect", { link = "DiagnosticInfo" })
		end,
	},
}
