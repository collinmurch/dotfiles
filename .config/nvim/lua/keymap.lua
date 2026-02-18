local map = vim.keymap.set

-- Helix-style undo
map("n", "U", "<C-R>", { noremap = true, desc = "Redo" })

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights" })

map("n", "<leader>c", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>c", "gc", { desc = "Toggle comment", remap = true })

-- Best binding ever
map("x", "<leader>p", [["_dP]], { desc = "Paste" })

-- Consistent which-key description with visual mode
map("n", "<leader>p", "p", { desc = "Paste" })

map("n", "<leader>,", function()
	vim.opt.list = not vim.opt.list._value
end, { desc = "Toggle whitespace characters" })

-- Git link functionality (matches Helix config)
map("n", "<leader>gl", function()
	local filename = vim.fn.expand("%")
	local line_number = vim.fn.line(".")
	local cmd = string.format("git-link.py %s %d", filename, line_number)
	vim.fn.system(cmd)
end, { desc = "Git link" })
