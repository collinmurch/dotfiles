return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	opts = {
		-- Base lang doesn't install for Svelte which breaks highlighting
		ensure_installed = { "javascript", "typescript" },
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		auto_install = true,
	},
}
