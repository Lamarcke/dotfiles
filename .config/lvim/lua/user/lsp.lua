-- use :LvimCacheReset after changing this
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_extend("force",
    lvim.lsp.automatic_configuration.skipped_servers, { "tsserver" })
