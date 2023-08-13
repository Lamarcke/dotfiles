-- For nvim-cmp setuf, see plugins/cmp.lua
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
        -- Keymaps are normally defined here, but i prefer to have a single file for all of them.
        local on_attach = function(_, bufnr)
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

        -- List of ignored servers (usually handled by external plugins)
        local ignored_servers = {
            "tsserver" -- handled by typescript-tools
        }

        mason_lspconfig.setup_handlers {
            function(server_name)
                for _, x in pairs(ignored_servers) do
                    if server_name == x then
                        return
                    end
                end

                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                }
            end
        }

        -- Autoformat setup --
        -- Switch for controlling whether you want autoformatting.
        --  Use :LspFormatToggle to toggle autoformatting on or off
        local format_is_enabled = true
        vim.api.nvim_create_user_command('LspFormatToggle', function()
            format_is_enabled = not format_is_enabled
            print('Setting autoformatting to: ' .. tostring(format_is_enabled))
        end, {})

        vim.api.nvim_create_user_command("LspFormat", function()
            vim.lsp.buf.format()
        end, {})

        -- Create an augroup that is used for managing our formatting autocmds.
        --      We need one augroup per client to make sure that multiple clients
        --      can attach to the same buffer without interfering with each other.
        local _augroups = {}
        local get_augroup = function(client)
            if not _augroups[client.id] then
                local group_name = 'lsp-format-' .. client.name
                local id = vim.api.nvim_create_augroup(group_name, { clear = true })
                _augroups[client.id] = id
            end

            return _augroups[client.id]
        end

        -- Whenever an LSP attaches to a buffer, we will run this function.
        --
        -- See `:help LspAttach` for more information about this autocmd event.
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
            -- This is where we attach the autoformatting for reasonable clients
            callback = function(args)
                local client_id = args.data.client_id
                local client = vim.lsp.get_client_by_id(client_id)
                local bufnr = args.buf

                -- Only attach to clients that support document formatting
                if not client.server_capabilities.documentFormattingProvider then
                    return
                end

                -- Tsserver usually works poorly. Sorry you work with bad languages
                -- You can remove this line if you know what you're doing :)
                if client.name == 'tsserver' then
                    return
                end

                -- Create an autocmd that will run *before* we save the buffer.
                --  Run the formatting command for the LSP that has just attached.
                vim.api.nvim_create_autocmd('BufWritePre', {
                    group = get_augroup(client),
                    buffer = bufnr,
                    callback = function()
                        if not format_is_enabled then
                            return
                        end

                        vim.lsp.buf.format {
                            async = false,
                            filter = function(c)
                                return c.id == client.id
                            end,
                        }

                        -- Reload prefs
                        require("core.prefs")
                    end,
                })
            end,
        })
    end
}
