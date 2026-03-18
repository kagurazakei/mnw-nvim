return {
	{
		"snacks.nvim",
		event = "DeferredUIEnter",
		after = function()
			require("snacks").setup({
				quickfile = { enabled = true },
				bigfile = { enabled = true },
				words = { enabled = true },
				scope = { enabled = true },
				input = { enabled = true },
				indent = { enabled = true },
				picker = { enabled = true },
				terminal = {
					enabled = true,
					win = {
						style = "float",
						border = "rounded",
						width = math.floor(vim.o.columns * 0.8),
						height = math.floor(vim.o.lines * 0.8),
					},
				},
				scroll = {
					enabled = true,
				},
				lazygit = {
					enabled = true,
					keys = {
						{
							icon = " ",
							key = "gz",
							desc = "Lazy Git",
							action = ":lua Snacks.lazygit.open()",
						},
					},
				},
				statuscolumn = { enabled = true },
				dashboard = {
					width = 60,
					row = nil, -- dashboard position. nil for center
					col = nil, -- dashboard position. nil for center
					pane_gap = 4, -- empty columns between vertical panes

					-- These settings are used by some built-in sections
					preset = {
						-- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
						---@type fun(cmd:string, opts:table)|nil
						pick = nil,

						-- Used by the `keys` section to show keymaps.
						-- Set your custom keymaps here.
						-- When using a function, the `items` argument are the default keymaps.
						---@type snacks.dashboard.Item[]
						keys = {
							{
								icon = " ",
								key = "f",
								desc = "Find File",
								action = ":lua Snacks.dashboard.pick('files')",
							},
							{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
							{
								icon = " ",
								key = "g",
								desc = "Find Text",
								action = ":lua Snacks.dashboard.pick('live_grep')",
							},
							{
								icon = " ",
								key = "r",
								desc = "Recent Files",
								action = ":lua Snacks.dashboard.pick('oldfiles')",
							},
							{
								icon = " ",
								key = "c",
								desc = "Config",
								action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
							},
							{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
							{
								icon = "󰒲 ",
								key = "lg",
								desc = "Themes",
								action = ":lua Snacks.lazygit.open()",
							},

							{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
						},
						header = [[
          ▄▄▄▄▄███████████████████▄▄▄▄▄     
        ▄██████████▀▀▀▀▀▀▀▀▀▀██████▀████▄   
       █▀████████▄             ▀▀████ ▀██▄  
      █▄▄██████████████████▄▄▄         ▄██▀ 
       ▀█████████████████████████▄    ▄██▀  
         ▀████▀▀▀▀▀▀▀▀▀▀▀▀█████████▄▄██▀    
           ▀███▄              ▀██████▀      
             ▀██████▄        ▄████▀         
                ▀█████▄▄▄▄▄▄▄███▀           
                  ▀████▀▀▀████▀             
                    ▀███▄███▀               
                       ▀█▀                  
      ]],
					},

					-- item field formatters
					formats = {
						icon = function(item)
							if item.file and item.icon == "file" or item.icon == "directory" then
								return require("snacks").dashboard.icon(item.file, item.icon)
							end
							return { item.icon, width = 2, hl = "icon" }
						end,
						footer = { "%s", align = "center" },
						header = { "%s", align = "center" },
						file = function(item, ctx)
							local fname = vim.fn.fnamemodify(item.file, ":~")
							fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
							if #fname > ctx.width then
								local dir = vim.fn.fnamemodify(fname, ":h")
								local file = vim.fn.fnamemodify(fname, ":t")
								if dir and file then
									file = file:sub(-(ctx.width - #dir - 2))
									fname = dir .. "/…" .. file
								end
							end
							local dir, file = fname:match("^(.*)/(.+)$")
							return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } }
								or { { fname, hl = "file" } }
						end,
					},

					sections = {
						{ section = "header" },

						{
							pane = 2,
							section = "terminal",
							cmd = "colorscript -e square",
							height = 5,
							padding = 1,
						},
						{
							pane = 2,
							icon = " ",
							title = "Git Status",
							section = "terminal",
							enabled = function()
								return Snacks.git.get_root() ~= nil
							end,
							cmd = "git status --short --branch --renames",
							height = 5,
							padding = 1,
							ttl = 5 * 60,
							indent = 3,
						},
						{ section = "keys", gap = 1, padding = 1 },
					},
				},
			})
		end,
		wk = {
			{ "<leader>d", desc = "Dashboard" },
		},
		keys = {
			{ "<leader>dd", "<cmd>lua Snacks.dashboard.open()<CR>", desc = "Open Dashboard" },
			{ "<leader>dh", "<cmd>Snacks dashboard header<CR>", desc = "Dashboard Header" },
			{ "<leader>dk", "<cmd>Snacks dashboard keys<CR>", desc = "Dashboard Keys" },
			{
				"<leader>uC",
				function()
					Snacks.picker.colorschemes()
				end,
				desc = "Colorschemes",
			},
		},
		cmd = {
			"Snacks",
			"SnacksDashboard",
		},
	},
}
