return {
	"cord.nvim",
	event = "VimEnter",
	build = ":Cord update",
	enabled = true,
	opts = {
		display = {
			theme = "catppuccin",
			flavor = "dark",
		},
	},
}
