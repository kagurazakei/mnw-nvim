return {

	{
		"lazydev.nvim",
		after = function()
			require("lazydev").setup({
				library = {
					-- Complete `vim.uv`
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			})
		end,
	},
	"luvit-meta",
}
