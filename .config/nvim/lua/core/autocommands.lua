-- close quickfix menu after selecting choice
vim.api.nvim_create_autocmd(
    "FileType", {
        pattern = { "qf" },
        command = "nnoremap <silent> <buffer> <CR> :close<CR>"
    })

-- Excerpt from LunarVim code
-- Use "q" to close some windows
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "qf", "help", "man", "floaterm", "lspinfo", "lsp-installer", "null-ls-info", "oil"
    },
    command = "nnoremap <silent> <buffer> q :close<CR>",

})
