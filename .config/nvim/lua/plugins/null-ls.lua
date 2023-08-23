-- Null-ls source example
--[[ {
    _validated = true,
    filetypes = {
      css = true,
      graphql = true,
      handlebars = true,
      html = true,
      javascript = true,
      javascriptreact = true,
      json = true,
      jsonc = true,
      less = true,
      markdown = true,
      ["markdown.mdx"] = true,
      scss = true,
      typescript = true,
      typescriptreact = true,
      vue = true,
      yaml = true
    },
    generator = {
      async = true,
      fn = <function 10>,
      opts = {
        args = <function 11>,
        command = "prettier",
        cwd = <function 12>,
        dynamic_command = <function 13>,
        ignore_stderr = true,
        name = "prettier",
        on_output = <function 14>,
        to_stdin = true
      },
      source_id = 3
    },
    id = 3,
    methods = {
      NULL_LS_FORMATTING = true,
      NULL_LS_RANGE_FORMATTING = true
    },
    name = "prettier"
} ]]
return {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "LspAttach" },
    config = function()
        local null_ls = require("null-ls")
        local code_actions = null_ls.builtins.code_actions
        local diagnostics = null_ls.builtins.diagnostics
        local formatting = null_ls.builtins.formatting

        null_ls.setup({
            sources = {
                code_actions.eslint_d,
                diagnostics.eslint_d,
                diagnostics.mypy,
                formatting.prettierd,
                formatting.stylua,
                formatting.black,
            },
        })
    end,
}
