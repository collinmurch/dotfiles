require("opt")
require("auto")
require("keymap")

-- Load per-machine overrides from ~/.config/nvim/lua/local.lua
local path = vim.fn.stdpath("config") .. "/lua/local.lua"
local uv = vim.uv or vim.loop
if uv and uv.fs_stat(path) then
	local ok, err = pcall(dofile, path)
	if not ok then
		vim.notify("Error in local.lua: " .. err, vim.log.levels.ERROR)
	end
end


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
