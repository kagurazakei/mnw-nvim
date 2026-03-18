AddKeyOpts = function(keys, opts)
	return vim.tbl_map(function(key)
		if type(key[#key]) == "table" then
			key[#key] = vim.tbl_deep_extend("keep", key[#key], opts)
		end
		return key
	end, keys)
end

require("gerg.misc")
require("gerg.treesitter")
require("gerg.keybinds")

vim.lsp.enable({
	"fish_lsp",
	"gleam",
	"lua_ls",
	"nil_ls",
	"basedpyright",
	"ts_ls",
	"marksman",
	"tinymist",
	"clangd",
})
