local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    { command = "eslint", filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" } },
    { command = "flake8", filetypes = { "python" } },
}
