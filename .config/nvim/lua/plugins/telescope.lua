return {

	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		},
	},
	config = function()
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				prompt_prefix = " ",
				select_caret = "",
				entry_prefix = "  ",
				mappings = {
					i = {
						["<C-u>"] = false,
						["<C-d>"] = false,
					},
				},
			},
			pickers = {
				find_files = {
					-- Show hidden files (.env, etc)
					hidden = false,
					previewer = false,
					layout_config = {
						width = 0.6,
						height = 0.7,
					},
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
				live_grep = {
					only_sort_text = true,
				},
				grep_string = {
					only_sort_text = true,
				},
				colorscheme = {
					previewer = true,
					enable_preview = true,
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
			},
		})

		telescope.load_extension("fzf")
	end,
}
