-- Leader key
vim.g.mapleader = " "

if vim.g.vscode then
	-- Do nothing for now
else
	-- LAZY STUFF
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end

	vim.opt.rtp:prepend(lazypath)
	require("lazy").setup({
		{ import = "plugins" },
		{ import = "plugins.languages" },
	}, {
		change_detection = {
			notify = false,
		},
	})
	-- END LAZY STUFF

	require("core")
end
