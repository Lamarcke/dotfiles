---@diagnostic disable: missing-fields
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		-- Allows to define text objects based on treesitter
		"nvim-treesitter/nvim-treesitter-textobjects",
		-- Allows to define which comments to use dinamically (make sure to set the comment plugin integration!)
		"JoosepAlviste/nvim-ts-context-commentstring",
		-- Auto close/rename html tags
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			-- Add languages to be installed here that you want installed for treesitter
			ensure_installed = { "markdown_inline", "regex" },

			-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
			auto_install = true,

			matchup = {
				enable = false,
			},

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
				disable = { "bash" },
			},
			indent = { enable = false },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					scope_incremental = "<c-s>",
					node_decremental = "<M-space>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
			autotag = {
				enable = true,
			},
		})
	end,
}
