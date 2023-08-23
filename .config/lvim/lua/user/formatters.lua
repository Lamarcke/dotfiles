local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {
        command = "prettierd",
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    },
    {
        command = "black",
        filetypes = { "python" },
    }
}
