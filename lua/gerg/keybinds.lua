local map = vim.keymap.set
local defaults = function(desc)
	return { noremap = true, silent = true, desc = desc }
end
-- General maps
map("n", "<leader>f", "+find/file")
map("n", "<leader>e", "<cmd>Yazi<cr>", { silent = true, desc = "Yazi Current Directory" })
map("n", "<leader>E", "<cmd>Yazi toggle<cr>", { silent = true, desc = "Yazi Toggle" })
map("n", "<leader>b", "+buffer")
map("n", "<leader>s", "+search")
map("n", "<leader>q", "+quit/session")
map({ "n", "v" }, "<leader>gi", "+git")
map("n", "<leader>u", "+ui")
map("n", "<leader>t", "+windows")
map("n", "<leader><tab>", "+tab")
map({ "n", "v" }, "<leader>D", "+debug")
map({ "n", "v" }, "<leader>c", "+code")

-- Tabs

map("n", "<leader>/", "gcc", { silent = true, desc = "Comment Current Line" })
map("v", "<leader>/", "gc", { silent = true, desc = "Comment Visual" })
map("n", "<leader><b>l", "<cmd>blast<cr>", { silent = true, desc = "Last Tab" })
map("n", "<leader><b>f", "<cmd>bfirst<cr>", { silent = true, desc = "First Tab" })
map("n", "<leader><b>n", "<cmd>bnew<cr>", { silent = true, desc = "New Tab" })
map("n", "<tab>", "<cmd>bnext<cr>", { silent = true, desc = "Next Tab" })
map("n", "<leader><b>d", "<cmd>bclose<cr>", { silent = true, desc = "Close Tab" })
map("n", "<S-tab>", "<cmd>bprevious<cr>", { silent = true, desc = "Previous Tab" })
-- Windows
map("n", "<leader>tw", "<C-W>p", { silent = true, desc = "Other Window" })
map("n", "<leader>td", "<C-W>c", { silent = true, desc = "Delete Window" })
map("n", "<leader>t-", "<C-W>s", { silent = true, desc = "Split Window Below" })
map("n", "<leader>t|", "<C-W>v", { silent = true, desc = "Split Window Right" })
-- map("n", "<leader>-", "<C-W>s", {silent = true, desc = "Split Window Below"})
map("n", "<leader>|", "<C-W>v", { silent = true, desc = "Split Window Right" })
-- Save file
map("n", "<leader>w", "<cmd>w<cr><esc>", { silent = true, desc = "Save file" })
-- Quit/Session
map("n", "<leader>qi", "<cmd>q<cr>!", { silent = true, desc = "Quit all" })
map("n", "<leader>qq", "<cmd>w<cr>q", { silent = true, desc = "Force Write & Quit" })
map("n", "<leader>qs", "function() lua require('persistence').load() end", { silent = true, desc = "Restore Session" })
map(
	"n",
	"<leader>ql",
	"function() lua require('persistence').load({ last = true })end",
	{ silent = true, desc = "Restore Last Session" }
)

map(
	"n",
	"<leader>qd",
	"function() lua require('persistence').stop() end",
	{ silent = true, desc = "Don't save current session" }
)

-- Toggle
map("n", "<leader>ul", function()
	ToggleLineNumber()
end, { silent = true, desc = "Toggle Line Numbers" })
map("n", "<leader>uL", function()
	ToggleRelativeLineNumber()
end, { silent = true, desc = "Toggle Relative Line Numbers" })
map("n", "<leader>uw", function()
	ToggleWrap()
end, { silent = true, desc = "Toggle Line Wrap" })

-- Inlay Hints
map("n", "<leader>uh", function()
	ToggleInlayHints()
end, { silent = true, desc = "Toggle Inlay Hints" })
-- Cool remaps
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move up when line is highlighted" })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move down when line is highlighted" })
map("n", "J", "mzJ`z", {
	silent = true,
	desc = "Allow cursor to stay in the same place after appeding to current line",
})
map("v", "<", "<gv", { silent = true, desc = "Indent while remaining in visual mode." })
map("v", ">", ">gv", { silent = true, desc = "Indent while remaining in visual mode." })
map("n", "<C-d>", "<C-d>zz", {
	silent = true,
	desc = "Allow <C-d> and <C-u> to keep the cursor in the middle",
})
map("n", "<C-u>", "<C-u>zz", { silent = true, desc = "Allow C-d and C-u to keep the cursor in the middle" })

-- Remap for dealing with word wrap and adding jumps to the jumplist.
map("n", "j", [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']], { silent = true, expr = true })
map("n", "k", [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']], { silent = true, expr = true })
map("n", "n", "nzzzv", { silent = true, desc = "Allow search terms to stay in the middle" })
map("n", "N", "Nzzzv", { silent = true, desc = "Allow search terms to stay in the middle" })

-- Paste stuff without saving the deleted word into the buffer

map({ "n", "v" }, "<leader>p", [["+p]], { silent = true, desc = "Paste to System Clipboards" })
map({ "n", "v" }, "<leader>P", [["+P]], { silent = true, desc = "Paste to System Clipboards" })

-- Copy stuff to system clipboard with <leader> + y or just y to have it just in vim
map({ "n", "v" }, "<leader>y", [["+y]], { silent = true, desc = "Copy to System Clipboard" })
map("n", "<leader>Y", [["+Y]], { silent = true, desc = "Copy to system clipboard" })

-- Delete to void register
map({ "n", "v" }, "<leader>d", [["_d]], { silent = true, desc = "Delete to void register" })

-- <C-c> instead of pressing esc just because
map("i", "<C-c>", "<Esc>", { silent = true, desc = "Exit insert mode" })
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer-script<CR>", { desc = "Switch between projects" })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- lsp
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		map("n", "<leader>lf", "<cmd>lua vim.diagnostic.open_float()<CR>", defaults("Lsp: Diagnostics"))
		map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", defaults("Lsp: Goto Definition"))
		map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", defaults("Lsp: Goto Declaration"))
		map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", defaults("Lsp: Goto References"))
		map("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<cr>", defaults("Lsp: Goto Implementation"))
		map("n", "gT", "<cmd>lua vim.lsp.buf.type_definition()<cr>", defaults("Lsp: Type Definition"))
		map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", defaults("Lsp: Hover"))
		map("n", "<leader>cw", "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", defaults("Lsp: Workspace Symbol"))
		map("n", "<leader>ra", "<cmd>lua vim.lsp.buf.rename()<cr>", defaults("Lsp: Rename"))
		map("n", "<leader>cr", "<cmd>lua vim.lsp.buf.references()<cr>", defaults("Lsp: References"))
		map("n", "<leader>fm", "<cmd>lua vim.lsp.buf.format()<cr>", defaults("Lsp: Run the lsp formatter"))
		map({ "n", "v" }, "<leader>ca", "<CMD>lua vim.lsp.buf.code_action()<CR>", defaults("Lsp: Code Actions"))
	end,
})
