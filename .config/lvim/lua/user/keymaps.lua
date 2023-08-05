-- Keymaps
-- These will probably be heavily inspired by IntelliJ IDEA


-- Delete to oblivion
-- cut with visual mode + x instead
vim.keymap.set('n', 'd', '"_d', { noremap = true })

vim.keymap.set({ 'n' }, 'ga', function()
    vim.lsp.buf.code_action()
end, { silent = true, noremap = true, desc = 'Code actions' })

-- Allows for joins without moving the cursor
vim.keymap.set("n", "J", "mzJ`z")

-- ** lvim default mappings
-- copilot is set to accept on Tab, like other editors
-- so we disable the default mapping for Tab
-- use <C-N> and <C-P> to navigate the completion menu
-- lvim.builtin.cmp.mapping["<Tab>"] = nil
-- lvim.builtin.cmp.mapping["<S-Tab>"] = nil
-- lvim.keys.normal_mode["<Tab>"] = nil
-- lvim.keys.insert_mode["<Tab>"] = nil

-- NvimTree mappings
vim.keymap.set("n", "<M-1>", "<cmd>NvimTreeToggle<CR>", { silent = true, desc = "Toggle NvimTree" })

-- bufferline mappings
-- make sure to remove the redudant ones from the default mappings
vim.keymap.set("n", "<M-l>", "<cmd>BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<M-h>", "<cmd>BufferLineCyclePrev<CR>", { silent = true })
vim.keymap.set("n", "<M-c>", "<cmd>BufferLinePick<CR>", { silent = true })
vim.keymap.set("n", "<M-x>", "<cmd>BufferLineCloseLeft<CR>", { silent = true })
vim.keymap.set("n", "<M-z>", "<cmd>BufferLineCloseRight<CR>", { silent = true })

-- Hop mappings
vim.keymap.set("n", "s", "<cmd>HopChar2<CR>", { silent = true, desc = "Hop to 2 char" })
vim.keymap.set("n", "S", "<cmd>HopWord<CR>", { silent = true, desc = "Hop to 2 char" })



-- Terminal
-- See here for reference:
-- https://github.com/LunarVim/LunarVim/blob/master/lua/lvim/core/terminal.lua#L4C3-L4C3
-- Use count + <M-F12> to open terminal a specific terminal
lvim.builtin.terminal.open_mapping = "<M-F12>"
lvim.builtin.terminal.direction = "float"
-- Removes the default M-1 - M-3 mappings
lvim.builtin.terminal.execs = {}


-- lvim's which key mappings already include "<leader>" as a prefix
-- replaces the default f with s
lvim.builtin.which_key.mappings["f"] = lvim.builtin.which_key.mappings["s"]
-- removes the default s (search) mapping
lvim.builtin.which_key.mappings["s"] = nil

-- Frecency mappings
-- Recent files in current project (CWD)
lvim.builtin.which_key.mappings["f"]["r"] = {
    "<Cmd>lua require('telescope').extensions.frecency.frecency({ workspace = 'CWD' })<CR>", "Recent files in project" }
-- Recent files in all projects
lvim.builtin.which_key.mappings["f"]["R"] = { "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>",
    "Recent files" }

-- Trouble mappings
lvim.builtin.which_key.mappings["t"] = {
    name = "Diagnostics",
    t = { "<cmd>TroubleToggle<cr>", "trouble" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
    l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
    r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}

-- Buffer whichkeys are too long
-- use the ones from the start of this file
lvim.builtin.which_key.mappings["b"] = nil

-- Removes the default NvimTree mapping (use <M-1> instead)
lvim.builtin.which_key.mappings["e"] = nil

-- Alpha mappings
-- lvim.builtin.alpha.dashboard.config
