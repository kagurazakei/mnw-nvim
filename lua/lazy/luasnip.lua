return {
	"luasnip.nvim",
	after = function()
		local ls = require("luasnip")

		ls.setup({
			enable_autosnippets = true,
			snip_env = {
				in_ts_group = Custom.in_ts_group,
			},
		})

		require("luasnip.loaders.from_lua").lazy_load({
			lazy_paths = { "/home/antonio/Projects/final-nvim/snippets" },
		})
	end,
}
