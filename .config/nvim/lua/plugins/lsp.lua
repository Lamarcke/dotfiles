return {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        -- Setup should be called first for mason and after for mason-lspconfig!
        { 'williamboman/mason.nvim' },
        'williamboman/mason-lspconfig.nvim',

        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        {
            'j-hui/fidget.nvim',
            tag = 'legacy',
            opts = {}
        },

        -- Additional lua configuration, makes nvim stuff amazing!
        'folke/neodev.nvim',
    },

    config = function()
        -- [[ Configure LSP ]]
        --  This function gets run when an LSP connects to a particular buffer.
        local on_attach = function(_, bufnr)
          -- Create a command `:Format` local to the LSP buffer
          vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            vim.lsp.buf.format()
          end, { desc = 'Format current buffer with LSP' })
        -- Create autocommand to format on save
            vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = buffer,
            callback = function()
                vim.lsp.buf.format { async = false }
            end
            })
        end

        -- Very important
        -- Load Mason first
        require("mason").setup()

        -- Setup neovim lua configuration
        require('neodev').setup()

        -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        -- Should be loaded after mason
        -- Ensure the servers above are installed
        local mason_lspconfig = require('mason-lspconfig')

        mason_lspconfig.setup()

        mason_lspconfig.setup_handlers {
          function(server_name)
            require('lspconfig')[server_name].setup {
              capabilities = capabilities,
              on_attach = on_attach,
            }
          end
        }



    end
}
