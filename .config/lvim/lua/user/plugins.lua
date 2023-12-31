local utils = require("user.utils")

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
        "nvim-telescope/telescope-frecency.nvim",
        dependencies = { "kkharji/sqlite.lua" },
        config = function()
            local telescope = require("telescope")
            lvim.builtin.telescope.extensions["frecency"] = {
                -- TODO: find a way to remove the previewer
                show_scores = false,
                show_unindexed = true,
                ignore_patterns = { "*.git/*", "*/tmp/*" },
                layout_strategy = "vertical",
                layout_config = {
                    vertical = {
                        preview_height = 0,
                        preview_width = 0,
                        previewer = false,
                    },
                    horizontal = {
                        previewer = false,
                        preview_height = 0,
                        preview_width = 0,
                    }
                }

            }
            telescope.load_extension("frecency")
        end
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
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        "debugloop/telescope-undo.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            lvim.builtin.telescope.extensions["undo"] = {
                initial_mode = "normal",

                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        preview_width = 0.8,
                    },
                },
                mappings = {
                    i = {
                        -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
                        -- you want to replicate these defaults and use the following actions. This means
                        -- installing as a dependency of telescope in it's `requirements` and loading this
                        -- extension from there instead of having the separate plugin definition as outlined
                        -- above.
                        ["<cr>"] = require("telescope-undo.actions").restore,
                        ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                        ["<C-cr>"] = require("telescope-undo.actions").yank_additions,
                    },
                    n = {
                        ["<cr>"] = require("telescope-undo.actions").restore,
                        ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                        ["<C-cr>"] = require("telescope-undo.actions").yank_additions,
                    },
                    v = {
                        ["<cr>"] = require("telescope-undo.actions").restore,
                        ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                        ["<C-cr>"] = require("telescope-undo.actions").yank_additions,
                    },
                }
            }
            require("telescope").load_extension("undo")
        end
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        config = function()
            --  Make sure to remove the default ts-server configuration from lvim
            --  see 'user.lsp'
            local typescript = require("typescript-tools")
            typescript.setup({
                publish_diagnostic_on = "change",
                settings = {
                    expose_as_code_action = { "fix_all", "add_missing_imports", "remove_unused" },
                }
            })
        end
    },
    {
        "karb94/neoscroll.nvim",
        opts = { hide_cursor = false, }
    },
    {
        "gabrielpoca/replacer.nvim",
    },
    {
        "antoinemadec/FixCursorHold.nvim",
        config = function()
            vim.g.cursorhold_updatetime = 200
        end
    },
}


-- plugin settings
lvim.builtin.cmp.confirm_opts.select = true

-- disable inline lens

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


local lvim_pickers = lvim.builtin.telescope.pickers

lvim_pickers.find_files = {
    theme = "dropdown",
    previewer = false,
}

lvim_pickers.buffers = {
    theme = "dropdown",
    previewer = false,
    initial_mode = "normal",
}

lvim_pickers.lsp_references = {
    theme = "dropdown",
    initial_mode = "normal",
}

lvim_pickers.lsp_definitions = {
    theme = "dropdown",
    initial_mode = "normal",
}

lvim_pickers.lsp_declarations = {
    theme = "dropdown",
    initial_mode = "normal",
}

lvim_pickers.lsp_implementations = {
    theme = "dropdown",
    initial_mode = "normal",
}

-- Terminal
-- See here for reference:
-- https://github.com/LunarVim/LunarVim/blob/master/lua/lvim/core/terminal.lua#L4C3-L4C3
-- Use count + <M-F12> to open terminal a specific terminal

lvim.builtin.terminal.open_mapping = "<M-3>"
lvim.builtin.terminal.direction = "float"
-- Removes the default M-1 - M-3 mappings
lvim.builtin.terminal.execs = {}

-- Alpha dashboard stuff
--

-- Use frecency instead of the default telescope oldfiles
lvim.builtin.alpha.dashboard.section.buttons.entries[4] = {
    "r", lvim.icons.ui.History .. "  Recent files", ":Telescope frecency<CR>"
}
-- Replaces the default function that defines a value for the header with a custom one:
-- The default code is here: https://github.com/LunarVim/LunarVim/blob/master/lua/lvim/core/alpha/dashboard.lua#L89
-- removing the function call to break your telescope.
-- why? no idea, just don't touch it lol.
lvim.builtin.alpha.dashboard.section.header.val = utils.get_responsive_header()

-- Disable dap (too much trouble)
lvim.builtin.dap.active = false

-- NvimTree
lvim.builtin.nvimtree.setup.auto_reload_on_write = true
lvim.builtin.nvimtree.setup.view.width = 35

-- Bigfile setup
lvim.builtin.bigfile.config = {
    pattern = function(bufnr, filesize_mib)
        -- you can't use `nvim_buf_line_count` because this runs on BufReadPre
        local file_contents = vim.fn.readfile(vim.api.nvim_buf_get_name(bufnr))
        local file_length = #file_contents
        local filetype = vim.filetype.match({ buf = bufnr })
        if file_length > 4000 then
            return true
        end
    end
}
