return {
	{
		"Comment.nvim",
		after = function()
			-- import comment plugin safely
			local comment = require("Comment")

			local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

			-- enable comment
			comment.setup({
				-- for commenting tsx and jsx files
				pre_hook = ts_context_commentstring.create_pre_hook(),
			})

			local ft = require("Comment.ft")
			ft.set("reason", { "//%s", "/*%s*/" })

			-- ======================
			-- <leader>/ Keybindings
			-- ======================
			local map = vim.keymap.set
			local opts = { noremap = true, silent = true }

			-- Normal mode: toggle line comment
			map("n", "<leader>/", function()
				require("Comment.api").toggle.linewise.current()
			end, opts)

			-- Visual mode: toggle line comment
			map("v", "<leader>/", function()
				local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
				vim.api.nvim_feedkeys(esc, "nx", false)
				require("Comment.api").toggle.linewise(vim.fn.visualmode())
			end, opts)
		end,
		wk = {
			{ "<leader>/", desc = "Toggle comment" },
		},
		keys = {
			{ "<leader>/", mode = "n", desc = "Toggle line comment" },
			{ "<leader>/", mode = "v", desc = "Toggle comment on selection" },
		},
	},

	{
		"nvim-ts-context-commentstring",
		after = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = true,
			})
		end,
	},
}
