return {
	"snacks.nvim",
		event = "DeferredUIEnter",
		before = function()
			LZN.trigger_load("lazydev.nvim")
			LZN.trigger_load("lspkind.nvim")
		end,
    dependencies = {
		"nvim-tree/nvim-web-devicons",
		-- No need for enabled condition here, handle it in opts
	},

	-- In lz.n, the config function is where you setup the plugin
	config = function()
		-- Check for nerd font
		local have_nerd_font = vim.g.have_nerd_font or false

		require("snacks").setup({
			indent = { enabled = true },
			bigfile = { enabled = true },
			quickfile = { enabled = false },
			input = { enabled = true },
			notifier = { enabled = false },
			notify = { enabled = true },
			scope = { enabled = true },
			lazygit = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			scroll = {
				enabled = true,
			},
			zen = { enabled = true },
			terminal = {
				enabled = true,
				win = {
					style = "float",
					border = "rounded",
					width = math.floor(vim.o.columns * 0.8),
					height = math.floor(vim.o.lines * 0.8),
				},
			},

			dashboard = {
				enabled = true,
				preset = {
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = ":lua Snacks.dashboard.pick('files')",
						},
						{
							icon = " ",
							key = "n",
							desc = "New File",
							action = ":ene | startinsert",
						},
						{
							icon = " ",
							key = "w",
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
							icon = " ",
							key = "c",
							desc = "Config",
							action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })",
						},
						{
							icon = "󰒲 ",
							key = "L",
							desc = "Lazy",
							action = ":Lazy",
							enabled = true,
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
				sections = {
					{ section = "header" },
					{
						pane = 2,
						section = "terminal",
						cmd = "colorscript -e square",
						height = 5,
						padding = 1,
					},
					{ section = "keys", gap = 1, padding = 1 },
					{
						pane = 2,
						icon = " ",
						desc = "Browse Repo",
						padding = 1,
						key = "b",
						action = function()
							Snacks.gitbrowse()
						end,
					},
					function()
						local in_git = Snacks.git.get_root() ~= nil
						local cmds = {
							{
								title = "Notifications",
								cmd = "gh notify -s -a -n5",
								action = function()
									vim.ui.open("https://github.com/notifications")
								end,
								key = "n",
								icon = " ",
								height = 5,
								enabled = true,
							},
							{
								title = "Open Issues",
								cmd = "gh issue list -L 3",
								key = "i",
								action = function()
									vim.fn.jobstart("gh issue list --web", { detach = true })
								end,
								icon = " ",
								height = 7,
							},
							{
								icon = " ",
								title = "Open PRs",
								cmd = "gh pr list -L 3",
								key = "P",
								action = function()
									vim.fn.jobstart("gh pr list --web", { detach = true })
								end,
								height = 7,
							},
							{
								icon = " ",
								title = "Git Status",
								cmd = "git --no-pager diff --stat -B -M -C",
								height = 10,
							},
						}
						return vim.tbl_map(function(cmd)
							return vim.tbl_extend("force", {
								pane = 2,
								section = "terminal",
								enabled = in_git,
								padding = 1,
								ttl = 5 * 60,
								indent = 3,
							}, cmd)
						end, cmds)
					end,
					{ section = "startup" },
				},
			},
		})
	end,
}
