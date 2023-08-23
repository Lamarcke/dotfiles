-- This file includes autocommands and usercommands
--
-- Some of these are excerpt from Lunarvim and Lazyvim
-- Note: LspAttach event stuff is at /plugins/lsp.lua config.

local function augroup(name)
	return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Autocommand that wraps either native bdelete or bufdelete.nvim.
vim.api.nvim_create_user_command("BufferKill", function()
	local bd_s, _ = pcall(require, "bufdelete")
	if bd_s then
		vim.cmd("Bdelete!")
		return
	end

	vim.cmd("bdelete!")
end, {})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("return-to-last-edit-position"),
	pattern = "*",
	callback = function()
		if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.fn.setpos(".", vim.fn.getpos("'\""))
			vim.api.nvim_feedkeys("zz", "n", true)
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"TelescopePrompt",
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"floaterm",
		"null-ls-info",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>q!<cr>", { buffer = event.buf, silent = true })
	end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

--  Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Automatically close NvimTree if it's the last buffer on window
vim.api.nvim_create_autocmd("QuitPre", {
	callback = function()
		local invalid_win = {}
		local wins = vim.api.nvim_list_wins()
		for _, w in ipairs(wins) do
			local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
			if bufname:match("NvimTree_") ~= nil then
				table.insert(invalid_win, w)
			end
		end
		if #invalid_win == #wins - 1 then
			-- Should quit, so we close all invalid windows.
			for _, w in ipairs(invalid_win) do
				vim.api.nvim_win_close(w, true)
			end
		end
	end,
})

-- Autocommand for nvim-lint
-- Disabled in favor of null-ls for now.
-- vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
-- 	callback = function()
-- 		local lint_status, lint = pcall(require, "lint")
-- 		if lint_status then
-- 			lint.try_lint()
-- 		end
-- 	end,
-- })
