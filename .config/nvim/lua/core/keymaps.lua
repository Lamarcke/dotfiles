-- Plugin setup should never be called here, but rather in lua/plugins
-- These keymaps may or may not work for you.

-- Delete to oblivion
-- cut with visual mode + x instead
vim.keymap.set("n", "d", '"_d', { noremap = true })
vim.keymap.set("n", "D", '"_D', { noremap = true })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Allows for joins without moving the cursor
vim.keymap.set("n", "J", "mzJ`z")

-- Clear search highlight
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")
vim.keymap.set("n", "<leader>h", "<cmd>nohl<CR>", { desc = "No HL Search" })

-- Move Lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move lines", silent = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines", silent = true })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move lines", silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move lines", silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines", silent = true })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move lines", silent = true })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Ctrl D and U with cursor in the middle
-- Disabled because Neoscroll uses these mappings.
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Save All
vim.keymap.set("n", "<leader>w", "<cmd>wa!<CR>", { desc = "Save all" })
-- Quit all
vim.keymap.set("n", "<leader>q", "<cmd>qa!<CR>", { desc = "Quit all" })

-- Close buffer
vim.keymap.set("n", "<leader>c", "<cmd>BufferKill<CR>", { desc = "Close buffer" })

-- Bufferline mappings
vim.keymap.set("n", "<M-l>", "<cmd>BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<M-h>", "<cmd>BufferLineCyclePrev<CR>", { silent = true })
vim.keymap.set("n", "<M-c>", "<cmd>BufferLinePick<CR>", { silent = true })
-- BufferKill is a custom command defined at /core/autocommands.lua.
vim.keymap.set("n", "<M-q>", "<cmd>BufferKill<CR>", { silent = true })
vim.keymap.set("n", "<M-S-q>", "<cmd>BufferLineCloseOthers<CR>", { silent = true })
vim.keymap.set("n", "<M-S-l>", "<cmd>BufferLineMoveNext<CR>", { silent = true })
vim.keymap.set("n", "<M-S-h>", "<cmd>BufferLineMovePrev<CR>", { silent = true })

-- Hop
vim.keymap.set("n", "s", "<cmd>HopChar2<CR>", { remap = true })
vim.keymap.set("n", "S", "<cmd>HopWord<CR>", { remap = true })

-- NvimTree (file manager)
local tree_status, _ = pcall(require, "nvim-tree")
if tree_status then
	vim.keymap.set("n", "<M-1>", "<cmd>NvimTreeToggle<CR>", { desc = "File navigation" })
end

-- LSP mappings
-- Some mappings are defined with WhichKey below!
vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover()
end, { desc = "Hover" })
vim.keymap.set("n", "gd", function()
	vim.lsp.buf.definition()
end, { desc = "Go to definition" })
vim.keymap.set("n", "gi", function()
	vim.lsp.buf.implementation()
end, { desc = "Go to implementation" })
vim.keymap.set("n", "gf", function()
	vim.lsp.buf.references()
end, { desc = "Go to references" })
vim.keymap.set("n", "gD", function()
	vim.lsp.buf.declaration()
end, { desc = "Go to declaration" })
vim.keymap.set("n", "gs", function()
	vim.lsp.buf.signature_help()
end, { desc = "Show signature help" })
vim.keymap.set("n", "gt", function()
	vim.lsp.buf.type_definition()
end, { desc = "Go to type definition" })
vim.keymap.set("n", "ga", function()
	vim.lsp.buf.code_action()
end, { desc = "Show code actions" })
vim.keymap.set("n", "E", function()
	vim.diagnostic.open_float()
end, { desc = "Show error diagnostics" })
vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_prev()
end, { desc = "Go to previous error" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_next()
end, { desc = "Go to next error" })

-- Alpha
vim.keymap.set({ "n", "x", "o" }, "<leader>;", "<cmd>Alpha<CR>", { desc = "Alpha Dashboard" })

-- ToggleTerm
-- I usually work with 2 terminals at most (one running the primary service/long commands, and another for running various commands)
-- These are mapped similarly to Jetbrains' Run and Terminal tool windows keymaps.
vim.keymap.set(
	{ "n", "t", "x", "o" },
	"<M-4>",
	"<cmd>1ToggleTerm size=20 dir=CWD direction=horizontal<CR>",
	{ desc = "Run window" }
)
vim.keymap.set(
	{ "n", "t", "x", "o" },
	"<M-F12>",
	"<cmd>2ToggleTerm size=20 dir=CWD direction=horizontal<CR>",
	{ desc = "Terminal window" }
)

local t_opts = { buffer = 0 }
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], t_opts)
vim.keymap.set("t", "jk", [[<C-\><C-n>]], t_opts)
vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], t_opts)
vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], t_opts)
vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], t_opts)
vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], t_opts)
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], t_opts)

-- WhichKey (leader) mappings
local which_key_status, which_key = pcall(require, "which-key")
if which_key_status then
	which_key.register({
		f = {
			name = "Find",
			f = { "<cmd>Telescope find_files<cr>", "Find File" },
			t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
			r = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
			l = { "<cmd>Telescope resume<cr>", "Resume last search" },
			c = { "<cmd>Telescope colorscheme<cr>", "Pick colorscheme" },
			p = { "<cmd>Telescope projects<cr>", "Projects" },
			u = { "<cmd>UndoTree Toggle<cr>", "Undo tree" },
		},
		s = {
			name = "Services",
		},
		r = {
			name = "LSP",
			r = {
				function()
					vim.lsp.buf.rename()
				end,
				"Rename",
			},
			a = {
				function()
					vim.lsp.buf.code_action()
				end,
				"Code actions",
			},
			f = {
				function()
					vim.lsp.buf.format()
				end,
				"Formatting",
			},
		},
		g = {
			name = "Git",
			p = { "<cmd>lua require('gitsigns').prev_hunk<CR>", "Previous Hunk" },
			n = { "<cmd>lua require('gitsigns').next_hunk<CR>", "Next Hunk" },
			P = { "<cmd>lua require('gitsigns').preview_hunk<CR>", "Preview Hunk" },
		},
		d = {
			name = "Diagnostics",
			t = { "<cmd>TroubleToggle<cr>", "trouble" },
			w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
			d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
			q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
			l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
			r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
		},
		p = {
			name = "Plugins",
			l = { "<cmd>Lazy<cr>", "Lazy" },
			m = { "<cmd>Mason<cr>", "Mason" },
		},
	}, { prefix = "<leader>" })
end
