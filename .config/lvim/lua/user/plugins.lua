lvim.plugins = {

    {
        "phaazon/hop.nvim",
        event = "BufRead",
        config = function()
            require("hop").setup()
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "TroubleToggle",
    },
    {
        "rebelot/kanagawa.nvim"
    },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = true,
                    auto_refresh = false,
                    keymap = {
                        jump_prev = "[[",
                        jump_next = "]]",
                        accept = "<CR>",
                        refresh = "gr",
                        open = "<M-CR>"
                    },
                    layout = {
                        position = "bottom", -- | top | left | right
                        ratio = 0.4
                    },
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept = "<Tab>",
                        accept_word = false,
                        accept_line = false,
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<C-]>",
                    },
                },
                filetypes = {
                    markdown = false,
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    ["."] = false,
                },
                copilot_node_command = 'node', -- Node.js version must be > 16.x
                server_opts_overrides = {},
            })                                 -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
        end,
    },
    {
        "ThePrimeagen/harpoon",
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },
    {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
            require("telescope").load_extension("frecency")
            lvim.builtin.telescope.extensions["frecency"] = {

            }
        end,
        dependencies = { "kkharji/sqlite.lua" }
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        'stevearc/dressing.nvim',
        opts = {},
    },
}


-- plugin settings
lvim.builtin.cmp.confirm_opts.select = true

-- lunarvim telescope settings

lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
lvim.builtin.telescope.defaults.borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
lvim.builtin.telescope.defaults.layout_config = {
    horizontal = {
        width = 0.9,
        height = 0.9,
        preview_width = 0.6,
    },
    vertical = {
        width = 0.3,
        height = 0.3,
        preview_height = 0.5,
    },
    flex = {
        horizontal = {
            preview_width = 0.9,
        },
    },
}
