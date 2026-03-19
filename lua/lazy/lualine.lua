return {
	"lualine.nvim",
	event = "DeferredUIEnter",
	before = function()
		LZN.trigger_load("nvim-web-devicons")
	end,
	after = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "rose-pine-moon",
				component_separators = { "", "" },

				section_separators = { left = "", right = "" },
				disabled_filetypes = { "NvimTree", "snacks_dashboard" },
			},
			sections = {
				lualine_a = { "mode", icon = " " },
				lualine_b = {
					{
						"filetype",
						icon_only = true,
						padding = { left = 1, right = 0 },
					},
					"filename",
				},

				lualine_c = {
					{
						"branch",
						icon = "",
					},
					{
						"diff",
						symbols = { added = " ", modified = " ", removed = " " },
						colored = false,
					},
				},
				lualine_x = {
					Snacks.profiler.status(),
        -- stylua: ignore
        {
          function() return require("noice").api.status.command.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          color = function() return { fg = Snacks.util.color("Statement") } end,
        },
        -- stylua: ignore
        {
          function() return require("noice").api.status.mode.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          color = function() return { fg = Snacks.util.color("Constant") } end,
        },
        -- stylua: ignore
        {
          function() return "  " .. require("dap").status() end,
          cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
          color = function() return { fg = Snacks.util.color("Debug") } end,
        },
        -- stylua: ignore
        {
          "diff",
          symbols = {
            added = " ",
            modified = "",
            removed = "",
          },
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
				},

				lualine_y = { clients_lsp },
				lualine_z = {
					{
						"progress",
						color = {
							bg = "none",
							fg = "lavender",
						},
					},
					{
						"location",
						color = { bg = "none", fg = "lavender" },
					},
					{
						"filetype",
						color = { bg = "none", fg = "lavender" },
					},
				},
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			tabline = {},
			extensions = { "fzf", "oil" },
		})
	end,
}
