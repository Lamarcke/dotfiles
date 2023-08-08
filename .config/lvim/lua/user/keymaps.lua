-- Keymaps
-- These will probably be heavily inspired by IntelliJ IDEA


-- Delete to oblivion
-- cut with visual mode + x instead
vim.keymap.set('n', 'd', '"_d', { noremap = true })
vim.keymap.set('n', 'D', '"_D', { noremap = true })

vim.keymap.set({ 'v', 'n' }, 'ga', function()
    vim.lsp.buf.code_action()
end, { silent = true, noremap = true, desc = 'Code actions' })


-- Allows for joins without moving the cursor
vim.keymap.set("n", "J", "mzJ`z")

-- ** lvim default mappings
-- copilot is set to accept on Tab, like other editors
-- so we disable the default mapping for Tab
-- use <C-N> and <C-P> to navigate the completion menu
lvim.builtin.cmp.mapping["<Tab>"] = nil
lvim.builtin.cmp.mapping["<S-Tab>"] = nil
lvim.keys.normal_mode["<Tab>"] = nil
lvim.keys.insert_mode["<Tab>"] = nil

-- NvimTree mappings
vim.keymap.set("n", "<M-1>", "<cmd>NvimTreeToggle<CR>", { silent = true, desc = "Toggle NvimTree" })

-- bufferline mappings
-- make sure to remove the redudant ones from the default mappings
vim.keymap.set("n", "<M-l>", "<cmd>BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<M-h>", "<cmd>BufferLineCyclePrev<CR>", { silent = true })
vim.keymap.set("n", "<M-c>", "<cmd>BufferLinePick<CR>", { silent = true })
vim.keymap.set("n", "<M-x>", "<cmd>BufferLineCloseLeft<CR>", { silent = true })
vim.keymap.set("n", "<M-z>", "<cmd>BufferLineCloseRight<CR>", { silent = true })
vim.keymap.set("n", "<M-q>", "<cmd>BufferKill<CR>", { silent = true })

-- Hop mappings
vim.keymap.set("n", "s", "<cmd>HopChar2<CR>", { silent = true, desc = "Hop to 2 char" })
vim.keymap.set("n", "S", "<cmd>HopWord<CR>", { silent = true, desc = "Hop to 2 char" })

-- LSP mappings
lvim.lsp.buffer_mappings.normal_mode["ga"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Show code actions" }
lvim.lsp.buffer_mappings.visual_mode["ga"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Show code actions" }
lvim.lsp.buffer_mappings.normal_mode["gf"] = { "<Cmd>lua vim.lsp.buf.references()<CR>", "Go to references" }
lvim.lsp.buffer_mappings.visual_mode["gf"] = { "<Cmd>lua vim.lsp.buf.references()<CR>", "Go to references" }
lvim.lsp.buffer_mappings.normal_mode["gr"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" }
lvim.lsp.buffer_mappings.visual_mode["gr"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" }




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

-- Undo tree telescope mappings
lvim.builtin.which_key.mappings["f"]["u"] = { "<Cmd>lua require('telescope').extensions.undo.undo()<CR>",
    "Undo tree" }

-- Trouble mappings
-- p for "problems"
lvim.builtin.which_key.mappings["t"] = {
    name = "Diagnostics",
    t = { "<cmd>TroubleToggle<cr>", "trouble" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
    l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
    r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}

-- Neotest mappings

-- lvim.builtin.which_key.mappings["t"] = {
--     name = "Test",
--     t = {
--         "function() require('neotest ').run.run(vim.fn.expand(" % ")) end", "Test file"
--     }


-- }

lvim.builtin.which_key.mappings["w"] = { "<cmd>wa!<CR>", "Save all" }

-- Buffer whichkeys are too long
-- use the ones from the start of this file
lvim.builtin.which_key.mappings["b"] = nil

-- Removes the default NvimTree mapping (use <M-1> instead)
lvim.builtin.which_key.mappings["e"] = nil

-- Alpha mappings
-- lvim.builtin.alpha.dashboard.config
--

-- nvim-dap is too much trouble, just use something else to debug visually
-- The actual plugin is removed at the "user.plugins" file
lvim.builtin.which_key.mappings["d"] = nil
