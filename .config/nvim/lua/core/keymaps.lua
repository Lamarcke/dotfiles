-- Plugin setup should never be called here, but rather in lua/plugins
-- These keymaps may or may not work for you.


-- Delete to oblivion
-- cut with visual mode + x instead
vim.keymap.set('n', 'd', '"_d', { noremap = true })
vim.keymap.set('n', 'D', '"_D', { noremap = true })

-- Allows for joins without moving the cursor
vim.keymap.set("n", "J", "mzJ`z")

-- Clear search highlight
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")
vim.keymap.set("n", "<leader>h", "<cmd>nohl<CR>", { desc = "No HL Search" })

-- Move Lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Ctrl D and U with cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Save All
vim.keymap.set("n", "<leader>w", "<cmd>wa!<CR>", { desc = "Save all" })
-- Quit all
vim.keymap.set("n", "<leader>q", "<cmd>qa!<CR>", { desc = "Quit all" })


-- Oil (file manager)
local oil_status, oil = pcall(require, "oil")
if oil_status then
    -- Custom function to automatically toggle Oil
    vim.keymap.set("n", "<leader>e", function()
        if vim.bo.filetype == 'oil' then
            oil.close()
        else
            oil.open()
        end
    end, { desc = "File navigation" })
end

-- LSP mappings
-- Some mappings are defined with WhichKey below!
local bufopts = { noremap = true, silent = false }
vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, { desc = "Hover" })
vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, { desc = "Go to definition" })
vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, { desc = "Go to implementation" })
vim.keymap.set('n', 'gf', function() vim.lsp.buf.references() end, { desc = "Go to references" })
vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, { desc = "Go to declaration" })
vim.keymap.set('n', 'gs', function() vim.lsp.buf.signature_help() end, { desc = "Show signature help" })
vim.keymap.set('n', 'gt', function() vim.lsp.buf.type_definition() end, { desc = "Go to type definition" })
vim.keymap.set('n', 'ga', function() vim.lsp.buf.code_action() end, { desc = "Show code actions" })
vim.keymap.set('n', 'E', function() vim.diagnostic.open_float() end, { desc = "Show error diagnostics" })
vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, { desc = "Go to previous error" })
vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, { desc = "Go to next error" })

-- WhichKey (leader) mappings
local which_key_status, which_key = pcall(require, "which-key")

if which_key_status then
    which_key.register({
        f = {
            name = "Find",
            f = { "<cmd>Telescope find_files<cr>", "Find File" },
            t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
        },
        r = {
            name = "LSP",
            r = { function() vim.lsp.buf.rename() end, "Rename" },
            a = { function() vim.lsp.buf.code_action() end, "Code actions" },
            f = { function() vim.lsp.buf.format() end, "Formatting" }

        }

    }, { prefix = "<leader>" })
end
