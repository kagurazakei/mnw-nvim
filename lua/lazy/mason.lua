return {
	{
		"mason.nvim",
		cmd = { "Mason", "MasonUpdate" },
		after = function()
			require("mason").setup({
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				},
			})
		end,
		wk = {
			{ "<leader>m", desc = "Mason" },
		},
		keys = {
			{ "<leader>mm", "<cmd>Mason<CR>", desc = "Open Mason" },
			{ "<leader>mu", "<cmd>MasonUpdate<CR>", desc = "Update Mason" },
		},
	},
	{
		"roslyn.nvim",
		ft = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets", "trpoj", "fproj" },
		after = function()
			require("roslyn").setup({
				-- your configuration comes here; leave empty for default settings
			})
		end,
	},

	{
		"nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		after = function()
			-- Configure roslyn LSP
			vim.lsp.config.roslyn = {
				filetypes = {
					"cs",
					"vb",
					"csproj",
					"sln",
					"slnx",
					"props",
					"csx",
					"targets",
					"tproj",
					"slngen",
					"fproj",
				},
				settings = {
					roslyn = {
						enable_roslyn_analysers = true,
						enable_import_completion = true,
						organize_imports_on_format = true,
						enable_decompilation_support = true,
					},
					["csharp|projects"] = {
						dotnet_enable_file_based_programs = true,
					},
					["csharp|code_lens"] = {
						dotnet_enable_references_code_lens = false,
					},
				},
			}

			-- LSP Keymaps
			local set = vim.keymap.set
			set("n", "<leader>lff", function()
				vim.lsp.buf.format({ async = true })
			end, { desc = "Format document" })
			set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename Symbol" })
			set({ "n", "i" }, "<f2>", vim.lsp.buf.rename, { desc = "Rename Symbol" })
			set({ "n", "i" }, "<f12>", vim.lsp.buf.definition, { desc = "Go to Definition" })
			set({ "n" }, "<leader>ld", vim.lsp.buf.definition, { desc = "Go to Definition" })
			set("n", "<leader>li", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
			set("n", "<leader>lh", vim.lsp.buf.signature_help, { desc = "Signature Help" })
			set("n", "<leader>lsR", vim.lsp.buf.references, { desc = "To to References" })
			set({ "n" }, "<leader>lsD", ":Trouble diagnostics<CR>", { desc = "Toggle Document Diagnostics" })
			set("n", "<leader>lsI", ":Trouble lsp_implementations<CR>", { desc = "Toggle LSP References" })
			set("n", "<leader>lsd", ":Trouble lsp_definitions<CR>", { desc = "Toggle LSP Definitions" })
			set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
			set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
		end,
		wk = {
			{ "<leader>l", desc = "LSP" },
			{ "<leader>ls", desc = "LSP Search" },
			{ "<leader>lf", desc = "LSP Format" },
		},
	},

	{
		"none-ls.nvim",
		enabled = false, -- Disabled in your config
		event = { "BufReadPre", "BufNewFile" },
		after = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- null_ls.builtins.formatting.stylua,
					-- null_ls.builtins.formatting.csharpier,
					-- null_ls.builtins.formatting.yamlfmt,
					-- null_ls.builtins.formatting.black,
					-- null_ls.builtins.formatting.isort,
				},
			})
		end,
	},

	{
		"mason-null-ls.nvim",
		enabled = false, -- Disabled in your config
		event = "VeryLazy",
		after = function()
			require("mason-null-ls").setup({
				automatic_setup = true,
			})
		end,
	},

	{
		"lsp_lines.nvim",
		event = { "BufReadPost", "BufNewFile" },
		after = function()
			require("lsp_lines").setup()

			vim.diagnostic.config({
				virtual_lines = false,
				virtual_text = true,
			})

			local function toggleLines()
				local new_value = not vim.diagnostic.config().virtual_lines
				vim.diagnostic.config({ virtual_lines = new_value, virtual_text = not new_value })
				return new_value
			end

			vim.keymap.set("n", "<leader>lu", toggleLines, { desc = "Toggle Underline Diagnostics", silent = true })
		end,
		wk = {
			{ "<leader>lu", desc = "Toggle LSP lines" },
		},
		keys = {
			{ "<leader>lu", mode = "n", desc = "Toggle Underline Diagnostics" },
		},
	},
}
