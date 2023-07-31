vim.keymap.set({ 'n' }, 'ga', function()
    vim.lsp.buf.code_action()
end, { silent = true, noremap = true, desc = 'Code actions' })

vim.keymap.set("n", "J", "mzJ`z")

vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
-- ** lvim default mappings
-- copilot is set to accept on Tab, like other editors
-- so we disable the default mapping for Tab
lvim.builtin.cmp.mapping["<Tab>"] = nil
lvim.keys.normal_mode["<Tab>"] = nil
lvim.keys.insert_mode["<Tab>"] = nil

-- lvim's which key mappings already include "<leader>" as a prefix
lvim.lsp.buffer_mappings.normal_mode["gj"] = lvim.builtin.which_key.mappings["l"]["j"]
lvim.lsp.buffer_mappings.normal_mode["gk"] = lvim.builtin.which_key.mappings["l"]["k"]
lvim.builtin.which_key.mappings["f"] = nil
lvim.builtin.which_key.mappings["f"] = lvim.builtin.which_key.mappings["s"]
lvim.builtin.which_key.mappings["s"] = nil
lvim.builtin.which_key.mappings["t"] = {
    name = "Diagnostics",
    t = { "<cmd>TroubleToggle<cr>", "trouble" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
    l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
    r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}
lvim.builtin.which_key.mappings["r"] = lvim.builtin.which_key.mappings["l"]["r"]

lvim.builtin.which_key.mappings["h"] = {
    name = "Harpoon",
    h = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "quick menu" },
    w = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "add file" },
}
lvim.builtin.which_key.mappings["1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "nav file 1" }
lvim.builtin.which_key.mappings["2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "nav file 2" }
lvim.builtin.which_key.mappings["3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "nav file 3" }
lvim.builtin.which_key.mappings["4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", "nav file 4" }
lvim.builtin.which_key.mappings["5"] = { "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", "nav file 5" }
