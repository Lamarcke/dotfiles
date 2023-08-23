vim.opt.termguicolors = true
vim.cmd 'colorscheme kanagawa'

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.clipboard = "unnamed,unnamedplus"
vim.opt.autoread = true

-- These can also be set per-project based on .editorconfig
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Update time

vim.opt.updatetime = 100

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8


-- Shown by lualine
vim.opt.showmode = false

vim.opt.conceallevel = 0
vim.opt.colorcolumn = "120"
-- Set this, otherwise the signcolumn will keep boucing around
vim.opt.signcolumn = "yes:1"
vim.opt.numberwidth = 4 -- default 2
