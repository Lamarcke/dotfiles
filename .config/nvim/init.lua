-- Leader key
vim.g.mapleader = " "
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

local go_path = vim.fn.system("which go")
local go_path = go_path:gsub("\n", "")
local go_command = go_path .. " version"
local go_version = vim.fn.system(go_command)
if #go_version > 0 then
	-- Match 'go' followed by any numbers until whitespace
	go_version = go_version:match("go[%d%.]+")
end

print(go_version)
