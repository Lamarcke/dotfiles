return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },             -- Required
        { 'williamboman/mason.nvim' },           -- Optional
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },     -- Required
        { 'hrsh7th/cmp-nvim-lsp' }, -- Required
        { 'hrsh7th/cmp-nvim-lua' },
        { 'hrsh7th/cmp-buffer' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'L3MON4D3/LuaSnip' }, -- Required
    },
    config = function()
        local lsp = require('lsp-zero').preset({
            manage_nvim_cmp = {
                set_extra_mappings = false,
                set_sources = "recommended",
            }
        })

        lsp.on_attach(function(client, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            -- This toggles auto formatting on save
            lsp.buffer_autoformat()
        end)

        -- (Optional) Configure lua language server for neovim
        require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

        lsp.setup()

        local cmp = require('cmp')
        local cmp_action = lsp.cmp_action()

        cmp.setup({
            preselect = 'item',
            completion = {
                completeopt = 'menu,menuone,noinsert'
            },
            mapping = {
                ["<Tab>"] = cmp_action.luasnip_supertab(),
                ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),

                ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            },

            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            }
        })

        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
}
