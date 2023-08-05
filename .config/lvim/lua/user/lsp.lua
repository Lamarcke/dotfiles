-- use :LvimCacheReset after changing this
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_extend("force",
    lvim.lsp.automatic_configuration.skipped_servers, { "tsserver" })

-- LSP plugins
local status, typescript = pcall(require, "typescript-tools")
if not status then
    return "typescript-tools not installed"
end

typescript.setup({
    expose_as_code_action = { "fix_all", "add_missing_imports", "remove_unused" },
})
